class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :home_team_goals
      t.integer :away_team_goals
      t.datetime :start_date

      t.timestamps
    end
  end
end
