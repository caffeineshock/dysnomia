class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :channel
      t.belongs_to :user

      t.timestamps
    end

    add_index :subscriptions, :user_id
    add_index :subscriptions, :channel_id
  end
end
