class AddAttachmentBackgroundToTenants < ActiveRecord::Migration
  def self.up
    change_table :tenants do |t|
      t.attachment :background
    end
  end

  def self.down
    remove_attachment :tenants, :background
  end
end
