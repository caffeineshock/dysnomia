class AddLastMessageAtToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :last_message_at, :datetime
  end
end
