class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name, unique: true
      t.string :hostname, unique: true

      t.timestamps
    end
  end
end
