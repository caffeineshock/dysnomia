class RenameHostnameFieldToSubdomainOnTenants < ActiveRecord::Migration
  def change
  	rename_column :tenants, :hostname, :subdomain
  end
end
