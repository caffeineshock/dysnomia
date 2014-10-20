class AddCategoryForEvents < ActiveRecord::Migration
  def change
  	create_table :categories do |t|
      t.string :color
      t.string :title
  	end

  	add_reference :events, :category, index: true
  end
end
