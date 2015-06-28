namespace :dysnomia do
  desc "Reindexes all models across all tenants"
  task reindex_solr: :environment do
  	[Task, Event, Page, Upload, Pad, User, Channel].each do |m|
      m.unscoped.reindex
    end

    Sunspot.commit
  end

end
