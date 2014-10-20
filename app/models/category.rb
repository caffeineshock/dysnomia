class Category < ActiveRecord::Base
  include Tenanted
  validates :title, uniqueness: {scope: :tenant_id}, presence: true, length: { maximum: 20 }
  validates :color, uniqueness: {scope: :tenant_id}, presence: true, format: { with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/ }
end
