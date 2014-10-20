class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end

    add_index :channels, :title, unique: true
    add_index :channels, :user_id
  end
end
