class ScoresController < ApplicationController

  def new
    @match = Match.where(id: params[:match_id]).first
    @match.scores.destroy_all
    goals = @match.home_team_goals + @match.away_team_goals
    goals.times do
      @match.scores.build
    end
  end

  def create
    binding.pry
  end

end
