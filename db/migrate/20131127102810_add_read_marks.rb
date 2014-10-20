class AddReadMarks < ActiveRecord::Migration
  def change
  	User.all.each do |u|
  	  %w{PublicActivity::Activity Task Event User Page}.each do |m|
  	    m.constantize.mark_as_read! :all, :for => u
  	  end
  	end
  end
end
