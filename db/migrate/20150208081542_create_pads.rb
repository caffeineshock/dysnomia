class CreatePads < ActiveRecord::Migration
  def change
    create_table :pads do |t|
      t.string :title
      t.string :internal_name
      t.integer :tenant_id

      t.index :tenant_id
      t.timestamps null: false
    end
  end
end
