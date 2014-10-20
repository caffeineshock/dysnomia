class RenameDueField < ActiveRecord::Migration
  def change
  	rename_column :tasks, :due, :due_at
  end
end
