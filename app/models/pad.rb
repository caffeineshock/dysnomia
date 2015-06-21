class Pad < ActiveRecord::Base
  include Tenanted
  include PublicActivity::Common
  include PublishCrudEvents
  extend FriendlyId

  friendly_id :title, use: :slugged
  acts_as_readable on: :created_at

  validates :title, uniqueness: {scope: :tenant_id}, presence: true, length: { maximum: 500 }
  attr_accessor :initial_text, :url

  searchable do
    text :title
  end
end
