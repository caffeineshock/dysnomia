class Task < ActiveRecord::Base
  include PublicActivity::Common
  include Tenanted
  include PublishCrudEvents
  include PgSearch

  # Unread
  acts_as_readable on: :created_at

  validates :title, presence: true, length: { maximum: 500 }
  validates :due_at, timeliness: { type: :date, allow_blank: true }

  has_many :assignments
  has_many :users, through: :assignments

  scope :eager, -> { includes(:users) }

  multisearchable against: [:title]

  def overdue?
    due_at and due_at < Date.today and not completed?
  end

  def assigned? user
    users.include? user
  end
end
