class AddMessagesCountToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :messages_count, :integer, default: 0
  end
end
