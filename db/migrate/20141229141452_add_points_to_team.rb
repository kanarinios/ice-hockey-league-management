class AddPointsToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :points, :integer, default: 0
  end
end
