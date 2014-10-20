class RemoveCreatorFromChannel < ActiveRecord::Migration
  def change
  	remove_column :channels, :user_id
  end
end
