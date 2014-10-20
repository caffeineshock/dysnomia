class ChangeDefaultValueForPublicOnChannel < ActiveRecord::Migration
  def change
  	change_column :channels, :public, :boolean, default: true
  end
end
