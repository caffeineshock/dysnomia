class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
	  t.belongs_to :task
      t.belongs_to :user

      t.timestamps
    end
      
    add_index :assignments, :user_id
    add_index :assignments, :task_id
  end
end
