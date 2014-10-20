class MakeUploadsMoreMinimal < ActiveRecord::Migration
  def change
  	remove_column :uploads, :name
  	remove_column :uploads, :description
  	add_column :uploads, :note, :string
  end
end
