class IndexModels < ActiveRecord::Migration
  def change
    [Task, Event, Page, Upload, Pad, User, Channel].each do |m|
      m.unscoped.reindex
    end

    Sunspot.commit
  end
end
