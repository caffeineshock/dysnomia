class AddJabberContactFieldsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :jabber_id, :string
  	add_column :users, :jabber_otr_fingerprint, :string
  end
end
