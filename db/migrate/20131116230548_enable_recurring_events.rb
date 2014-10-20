class EnableRecurringEvents < ActiveRecord::Migration
  def change
  	add_column :events, :recurring, :boolean
  	add_column :events, :schedule, :string
  end
end
