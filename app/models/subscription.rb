class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  def self.muted_for user
    where(user: user, muted: true)
  end
end
