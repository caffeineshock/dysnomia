class AddIndicesForUnread < ActiveRecord::Migration
  def change
  	%w{messages tasks users pages events}.each do |t|
  		add_index t, :created_at
  	end
  end
end
