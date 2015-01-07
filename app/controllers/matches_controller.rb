class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def new
    @match = Match.new
  end

  def new_scores
    @match = Match.where(id: params[:match_id]).first
    @match.scores.destroy_all
    goals = @match.home_team_goals + @match.away_team_goals
    goals.times do
      @match.scores.build
    end
  end

  def edit
    @match = Match.find(params[:id])
  end

  def show
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])

    if @match.scores_present?
      old_scores = @match.results
    end
    update_policy = Match::UpdatePolicy.new(@match, old_scores)

    if @match.update(match_attributes)
      if update_policy.result_changed?
        Teams::TableUpdateService.update_points(@match)
      end
      if params[:match].present? && params[:match][:scores_attributes].present?
        scores = params[:match][:scores_attributes]
        scores.each do |score|
          Score.create(match_id: @match.id, player_id: score[1][:player_id])
        end
        redirect_to '/matches'
      else
        redirect_to new_score_path(match_id: @match.id)
      end
    else
      render 'edit'
    end
  end

  def create
    @match = Match.new(match_attributes)

    if @match.save
      redirect_to '/matches'
    else
      render 'new'
    end
  end

   def destroy
    @match = Match.find(params[:id])
    @match.destroy

    redirect_to matches_path
  end

  private

  def match_attributes
    params[:match].permit(:start_date, :home_team_id, :away_team_id, :home_team_goals, :away_team_goals)
  end
end
