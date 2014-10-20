class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :user_id
      t.integer :channel_id

      t.timestamps
    end

    add_index :messages, :user_id
    add_index :messages, :channel_id
  end
end
