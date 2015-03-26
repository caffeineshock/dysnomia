class Users::InvitationsController < Devise::InvitationsController
  before_filter :update_sanitized_params, only: :update
  prepend_around_filter :scope_current_tenant

  def create
    if user = User.where(email: invite_params[:email]).take
      user.tenants << current_tenant
      set_flash_message :notice, :added_user_to_tenant
      redirect_to users_path
    else
      super
    end
  end

  # PUT /resource/invitation
  def update
    respond_to do |format|
      format.js do
        invitation_token = Devise.token_generator.digest(resource_class, :invitation_token, update_resource_params[:invitation_token])
        self.resource = resource_class.where(invitation_token: invitation_token).first
        resource.skip_password = true
        resource.update_attributes update_resource_params.except(:invitation_token)
      end
      format.html do
        super do |u|
          u.approved = true
        end
      end
    end
  end

  protected

  def update_sanitized_params
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:username, :password, :password_confirmation, :invitation_token)
    end
  end
end
