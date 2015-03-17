class AddStartpageFlagToPages < ActiveRecord::Migration
  def up
  	add_column :pages, :startpage, :boolean, default: false
  	Page.unscoped.find(1).update(startpage: true)
  rescue ActiveRecord::RecordNotFound	
  end

  def down
  	remove_column :pages, :startpage
  end
end
