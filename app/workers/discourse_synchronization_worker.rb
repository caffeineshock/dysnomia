class DiscourseSynchronizationWorker < DiscourseWorker
  include Sidekiq::Worker

  def perform(user_id)
  	for_each_tenant(user_id) do |u,t|
      client(t) do |c|
        c.sso_sync(
          sso_secret: t.settings(:discourse).sso_secret
          name: u.username
          username: u.username
          email: u.email
          external_id: user_id
        )
        c.update_avatar(username: username, file: t.url + u.avatar.url)
      end
    end
  rescue DiscourseApi::Error
    logger.warn "User with ID '#{user_id}' couldn't be saved by discourse (does a discourse account exist?)"
  end

  private 

  def settings_missing? tenant
    %i(url api_key).any? { |s| tenant.settings(:discourse).send(s).blank? }
  end
end