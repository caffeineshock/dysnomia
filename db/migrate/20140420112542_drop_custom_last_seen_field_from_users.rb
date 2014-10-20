class DropCustomLastSeenFieldFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :current_sign_in_at
  	rename_column :users, :last_seen_at, :current_sign_in_at
  end
end
