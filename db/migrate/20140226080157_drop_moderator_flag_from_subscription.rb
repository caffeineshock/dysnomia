class DropModeratorFlagFromSubscription < ActiveRecord::Migration
  def change
  	remove_column :subscriptions, :moderator
  end
end
