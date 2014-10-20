class ErrorsController < ApplicationController
  def show
  	@moderator = User.moderators.decorate
  	@admins = User.admins.decorate
  	@code  = params[:code] || 500
    render status: @code
  end
end
