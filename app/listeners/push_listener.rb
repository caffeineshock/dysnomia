class PushListener
  def initialize user_id, tenant_id
    @service = PushNotificationService.new(user_id, tenant_id)
  end

  def created_activity(activity)
    created(activity)
  end

  def created(subject)
    @service.push subject, :add
  end

  def updated(subject)
    @service.push subject, :add
  end

  def destroyed(subject)
    @service.push subject, :remove
  end
end
