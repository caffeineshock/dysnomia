class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize_miniprofiler
  before_filter :authenticate_user_from_token!
  before_action :authenticate_user!
  before_action :retrieve_unread, unless: :devise_controller?
  before_action :set_mailer_host
  before_filter :configure_permitted_parameters, if: :devise_controller?
  prepend_around_filter :scope_current_tenant

  layout Proc.new { |controller| "#{controller.user_signed_in? ? '' : 'not_'}signed_in" }

  protected

  def set_mailer_host
    ActionMailer::Base.default_url_options = {:host => request.host_with_port, :protocol => request.protocol}
  end

  def authenticate_inviter!
    authorize_moderator
    super
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  private

  def current_tenant
    Tenant.find_by_hostname! request.host
  end

  helper_method :current_tenant

  def other_tenants
    choosable_tenants = Tenant.accessable current_user
    choosable_tenants - [current_tenant]
  end

  helper_method :other_tenants

  def scope_current_tenant
    Tenant.current_id = current_tenant.id
    yield
  ensure
    Tenant.current_id = nil
  end

  def xeditable? object = nil
    true # Or something like current_user.xeditable?
  end

  helper_method :xeditable?

  def retrieve_unread
    unread_objs unless current_user.nil?
  end

  def unread_objs
    @unread ||= %w{PublicActivity::Activity Task Event Page Message Upload Pad}.each_with_object({}) do |m,u|
      u[model_short_name m] = m.constantize.unread_by(current_user).pluck(:id)
    end
  end

  helper_method :unread_objs

  def muted_channels
    Subscription.muted_for(current_user).pluck(:channel_id)
  end

  helper_method :muted_channels

  def model_short_name obj
    obj.split('::')[-1].downcase
  end

  helper_method :model_short_name

  def authorize_miniprofiler
    Rack::MiniProfiler.authorize_request if Rails.env.development? and user_signed_in? and current_user.admin? 
  end

  def authorize_moderator
    unauthorized_access unless current_user.moderator_or_admin?
  end

  def authorize_admin
    unauthorized_access unless current_user.admin?
  end

  def forum_url
    current_tenant.settings(:discourse).url
  end

  helper_method :forum_url

  def etherpad_available?
    Settings.etherpad_address.present? and Rails.application.secrets.etherpad_api_key.present? and Settings.etherpad_api_version.present?
  end

  helper_method :etherpad_available?

  private 

  def unauthorized_access
    redirect_to root_url, alert: "Unautorisierter Zugriff"
  end

  def authenticate_user_from_token!
    access_token = params[:access_token].presence
    user = access_token && User.find_by_access_token(access_token.to_s)
     
    if user
      sign_in user, store: false
    end
  end
end
