class DiscourseSynchronizationWorker
  include Sidekiq::Worker

  def perform(user_id, username)
  	user = User.find(user_id)

    user.tenants.each do |t|
  	  unless settings_missing? t
  	    DiscourseApi::Client.new(t.settings(:discourse).url, t.settings(:discourse).api_key, 'system').tap do |c|
      	  c.update_email(username, user.email)
          c.update_avatar(username, user.avatar.url)
          c.update_username(username, user.username)
        end
      else
    	  logger.warn "User '#{username}' was not synchronized for tenant #{t.name} as some settings were nil"
      end
    end
  rescue DiscourseApi::Error
    logger.warn "User '#{username}' couldn't be saved by discourse (does a discourse account exist?)"
  rescue ActiveRecord::RecordNotFound
    logger.warn "User '#{username}' doesn't exist in our database anymore (or the ID has changed)"
  end

  private 

  def settings_missing? tenant
    %i(url api_key).any? { |s| tenant.settings(:discourse).send(s).blank? }
  end
end