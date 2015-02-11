class DiscourseSynchronizationWorker < DiscourseWorker
  include Sidekiq::Worker

  def perform(user_id, username)
  	for_each_tenant(user_id) do |u,t|
      client(t) do |c|
      	c.update_email(username, u.email)
        c.update_avatar(username: username, file: t.url + u.avatar.url)
        c.update_username(username, u.username)
      end
    end
  rescue DiscourseApi::Error
    logger.warn "User '#{username}' couldn't be saved by discourse (does a discourse account exist?)"
  end

  private 

  def settings_missing? tenant
    %i(url api_key).any? { |s| tenant.settings(:discourse).send(s).blank? }
  end
end