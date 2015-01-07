class StatisticsController < ApplicationController

  def index
  end

  def top_scorer
    @players = Player.all.sort_by {|player| player.goals }.reverse
  end

  private

  def player_attributes
    params[:player].permit(:first_name, :last_name, :team_id, :photo)
  end
end
