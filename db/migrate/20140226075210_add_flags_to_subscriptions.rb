class AddFlagsToSubscriptions < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :muted, :boolean, default: false
  	add_column :subscriptions, :moderator, :boolean, default: false
  end
end
