class ChannelDecorator < ApplicationDecorator
  delegate_all
  decorates_association :users

  def unread_messages_icon
   unread_messages? ? unread_icon! : ""
  end

  private

  def unread_messages?
    (object.messages.map { |o| o.id } & h.unread_objs["message"]).size > 0 unless object.messages.empty?
  end
end
