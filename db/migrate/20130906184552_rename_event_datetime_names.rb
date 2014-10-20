class RenameEventDatetimeNames < ActiveRecord::Migration
  def change
  	rename_column :events, :start, :starts_at
  	rename_column :events, :end, :ends_at
  end
end
