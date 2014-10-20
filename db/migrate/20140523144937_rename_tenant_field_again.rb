class RenameTenantFieldAgain < ActiveRecord::Migration
  def change
  	rename_column :tenants, :subdomain, :hostname
  end
end
