class Page < ActiveRecord::Base
  include PublicActivity::Common
  include Tenanted
  include Postprocess
  include PublishCrudEvents
  extend FriendlyId
  
  friendly_id :title, use: :slugged

  acts_as_processable :content
  acts_as_readable on: :created_at

  validates :title, uniqueness: {scope: :tenant_id}, presence: true, length: { maximum: 500 }

  before_save :highlander_check

  def self.startpage
  	self.where(startpage: true).take!
  end

  private

  def highlander_check
    if startpage
      Page.where(tenant_id: tenant_id).where().not(id: id).update_all(startpage: false)
    end
  end  
end