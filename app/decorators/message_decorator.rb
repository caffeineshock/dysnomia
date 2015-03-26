class MessageDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def distance_between message
    [message.created_at, created_at].sort.tap do |m|
      return m.second - m.first
    end
  end

  def different_date message
    message.created_at.to_date != created_at.to_date
  end
end
