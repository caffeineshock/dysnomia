class DiscourseSignOutWorker < DiscourseWorker
  include Sidekiq::Worker

  def perform(user_id)
    for_each_tenant(user_id) do |u,t|
  	  client(t) do |c|
        c.log_out(user_id)
      end
    end
  rescue DiscourseApi::Error
    logger.warn "User with ID '#{user_id}' couldn't be signed out from discourse (does a discourse account exist?)"
  end
end