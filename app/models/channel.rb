class Channel < ActiveRecord::Base
  include PublicActivity::Common
  include Tenanted
  extend FriendlyId
  
  friendly_id :title, use: :slugged

  validates :title, presence: true, length: { maximum: 500 }, uniqueness: true
  validates :subscriptions, presence: true, unless: :public?
  
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :messages, dependent: :destroy

  def toggle_muted_for user
    subscription(user).toggle(:muted).save
  end

  def unsubscribe user
    subscription(user).destroy
    destroy unless public? or subscriptions.size > 1
  end

  def visible_for? user
    users.include? user or public?
  end

  def last_message_at
    @last_message_at ||= Message.last_in_channel(self)
  end

  def muted_by? user
    subscription(user).nil? ? true : subscription(user).muted?
  end

  def has_unread_message? user
    messages.find { |m| m.unread? user } != nil
  end

  def faye
    "/chat/#{id}"
  end

  def mark_messages_read_for user
    Message.mark_as_read! messages.to_a, for: user 
  end

  def self.visible_for user
    joins(:subscriptions).where("public = 't' OR subscriptions.user_id = ?", user.id).distinct
  end

  private

  def subscription user
    subscriptions.find { |s| s.user = user }
  end
end
