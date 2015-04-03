PublicActivity::Activity.module_eval do
  include Tenanted
  include Wisper::Publisher
  include Draper::Decoratable

  # Unread
  acts_as_readable on: :created_at

  after_create do
    publish(:created_activity, self)
  end
end
