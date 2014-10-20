class RemoveLimitOnSchedule < ActiveRecord::Migration
  def change
  	change_column :events, :schedule, :text, :limit => nil
  end
end
