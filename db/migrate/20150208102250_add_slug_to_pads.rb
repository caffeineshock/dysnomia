class AddSlugToPads < ActiveRecord::Migration
  def change
  	add_column :pads, :slug, :string
    add_index :pads, :slug
  end
end
