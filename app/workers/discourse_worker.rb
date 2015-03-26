class DiscourseWorker
  protected

  def for_each_tenant user_id
    u = User.find(user_id)

    u.tenants.each do |t|
      yield u, t
    end
  rescue ActiveRecord::RecordNotFound
    logger.warn "User with ID '#{user_id}' could not be found in DB"
  end

  def client t
    unless settings_missing? t
      DiscourseApi::Client.new(t.settings(:discourse).url, t.settings(:discourse).api_key, 'system').tap do |c|
        yield c
      end
    end
  end

  private

  def settings_missing? tenant
    %i(url api_key).any? { |s| tenant.settings(:discourse).send(s).blank? }
  end
end
