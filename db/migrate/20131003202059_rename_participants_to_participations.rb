class RenameParticipantsToParticipations < ActiveRecord::Migration
  def change
  	rename_table :participants, :participations
  end
end
