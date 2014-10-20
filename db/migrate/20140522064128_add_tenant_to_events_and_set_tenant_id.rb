class AddTenantToEventsAndSetTenantId < ActiveRecord::Migration
  def change
  	add_column :events, :tenant_id, :integer
    add_index :events, :tenant_id
    add_index :memberships, :user_id
    add_index :memberships, :tenant_id
  end
end
