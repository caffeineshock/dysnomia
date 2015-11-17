class RebuildMultisearchIndices < ActiveRecord::Migration
  def change
    %w{Task Event Page Upload Pad Channel}.each do |m|
     PgSearch::Multisearch.rebuild(m.constantize)
    end
  end
end
