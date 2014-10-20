class AddTenantToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :tenant_id, :integer
    add_index :tasks, :tenant_id
  end
end
