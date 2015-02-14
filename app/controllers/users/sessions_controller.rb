class Users::SessionsController < Devise::SessionsController
  before_filter :single_sign_out, only: :destroy

  def single_sign_out
    DiscourseSignOutWorker.perform_async(current_user.id)
  end

  def impersonate user
  	raise "yay #{user}"
  end
end