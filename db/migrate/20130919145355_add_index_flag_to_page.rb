class AddIndexFlagToPage < ActiveRecord::Migration
  def change
  	add_column :pages, :index, :boolean
  end
end
