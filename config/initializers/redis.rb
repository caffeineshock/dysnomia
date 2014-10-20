Dysnomia::Application.config.tap do |c| 
  c.before_configuration do
    c.session_store :redis_store, servers: [Settings.redis_url + '/session']
    c.cache_store = :redis_store, Settings.redis_url + '/cache', { expires: 90.minutes }
  end
end