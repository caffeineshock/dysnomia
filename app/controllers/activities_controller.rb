class ActivitiesController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :authenticate_silently

  def index
    filter = {}

    if params[:filter] and %w{page event task upload pad}.include? params[:filter]
      filter = PublicActivity::Activity.arel_table[:key].matches("#{params[:filter]}.%")
    end

    @activities = PublicActivity::Activity.order(created_at: :desc).where(filter).page(params[:page]).per_page(50)
    @decorated_activities = PublicActivity::ActivitiesDecorator.decorate(@activities)
    @unread_activities = PublicActivity::Activity.unread_by(current_user).pluck(:id)
    PublicActivity::Activity.mark_as_read! @activities.to_a, :for => current_user

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
    end
  end

  private

  def authenticate_silently
    redirect_to new_user_session_path unless user_signed_in?
  end
end
