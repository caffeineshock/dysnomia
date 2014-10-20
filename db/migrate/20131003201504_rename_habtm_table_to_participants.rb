class RenameHabtmTableToParticipants < ActiveRecord::Migration
  def change
  	drop_table :events_users

    create_table :participants do |t|
      t.belongs_to :event
      t.belongs_to :user

      t.timestamps
    end
    
    add_index :participants, :user_id
    add_index :participants, :event_id
  end
end
