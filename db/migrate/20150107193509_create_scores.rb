class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :player_id
      t.integer :match_id
      t.integer :terce
      t.string :time

      t.timestamps
    end
  end
end
