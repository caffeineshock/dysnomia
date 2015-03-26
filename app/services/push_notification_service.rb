class PushNotificationService
  def initialize user_id, tenant_id
    @user_id = user_id
    @tenant_id = tenant_id
  end

  def push object, type
    raise RuntimeError, "Incorrect type" unless %i(add remove).include? type

    PrivatePub.publish_to "/unread/#{@tenant_id}", {
      source: @user_id,
      type: type.to_s,
      id: object.id,
      model: object.class.name.demodulize.downcase
    }
  end
end
