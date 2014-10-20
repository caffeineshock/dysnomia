class Upload < ActiveRecord::Base
  include PublicActivity::Common 
  include Tenanted
  include Postprocess
  include PublishCrudEvents

  acts_as_processable :note
  has_attached_file :file
  acts_as_readable on: :created_at

  validates :file, attachment_presence: true
  do_not_validate_attachment_file_type :file

  def extension
  	file_file_name.match(/\.(\w+)$/)[1]
  end
end
