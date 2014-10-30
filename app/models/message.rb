class Message < ActiveRecord::Base
  include Postprocess

  acts_as_processable :body

  belongs_to :user
  belongs_to :channel, counter_cache: true

  after_create :update_channel_timestamp

  # Unread
  acts_as_readable on: :created_at

  validates :body, presence: true

  def self.unread_by user
  	visible = Channel.visible_for user
  	super(user).where(channel: visible)
  end

  def self.last_in_channel(channel)
  	where(channel: channel).order(created_at: :desc).limit(1).pluck(:created_at).first
  end

  private

  def update_channel_timestamp
    channel.touch(:last_message_at)
  end
end
