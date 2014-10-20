class AddTenantAssociationsToOtherModels < ActiveRecord::Migration
  def change
  	%w{pages activities channels categories settings uploads}.each do |table|
  	  add_column table.to_sym, :tenant_id, :integer
      add_index table.to_sym, :tenant_id
    end

    create_table :memberships do |t|
	    t.belongs_to :tenant
      t.belongs_to :user

      t.timestamps
    end
  end
end
