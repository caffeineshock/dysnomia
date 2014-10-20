class AddRoleToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :role, :integer, default: 0
  	User.unscoped.where(admin: true).update_all(role: 1)
  	remove_column :users, :admin
  end

  def down
  	add_column :users, :admin, :boolean, default: false
  	User.unscoped.where("role > 0").update_all(admin: true)
  	remove_column :users, :role
  end
end
