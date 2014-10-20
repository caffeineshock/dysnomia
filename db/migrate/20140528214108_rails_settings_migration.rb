class RailsSettingsMigration < ActiveRecord::Migration
  def change
    drop_table :settings
    
    create_table :settings do |t|
      t.string     :var,    :null => false
      t.text       :value
      t.references :target, :null => false, :polymorphic => true
      t.timestamps
    end
    add_index :settings, [ :target_type, :target_id, :var ], :unique => true
  end
end
