class RemoveIndexFlagFromPage < ActiveRecord::Migration
  def change
  	remove_column :pages, :index
  end
end
