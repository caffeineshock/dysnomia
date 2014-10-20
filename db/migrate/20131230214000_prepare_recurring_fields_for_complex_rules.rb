class PrepareRecurringFieldsForComplexRules < ActiveRecord::Migration
  def change
  	remove_column :events, :recurring
  	change_column :events, :schedule, :text
  end
end
