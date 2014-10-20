class ChangeEventDueToStartAndEndDate < ActiveRecord::Migration
  def change
  	rename_column :events, :due, :start
  	add_column :events, :end, :datetime
  end
end
