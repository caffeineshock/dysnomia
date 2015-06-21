class RemoveUniqueIndexFromChannel < ActiveRecord::Migration
  def change
    remove_index :channels, :title
    add_index :channels, :title
  end
end
