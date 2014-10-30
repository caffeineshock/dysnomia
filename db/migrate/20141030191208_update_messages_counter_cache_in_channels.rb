class UpdateMessagesCounterCacheInChannels < ActiveRecord::Migration
  def up
    Channel.unscoped.each { |c| Channel.unscoped.reset_counters(c.id, :messages) }
  end
end
