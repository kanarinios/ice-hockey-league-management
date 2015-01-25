class MatchesController < ApplicationController
  def index
    if params[:query].present?
      @matches = Match.search(params[:query])
    else
      @matches = Match.all
    end
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
        flash[:success] = t(".player_scores_success")
        redirect_to '/matches'
      else
        flash[:success] = t(".score_success")
        redirect_to new_score_path(match_id: @match.id)
      end
    else
      flash.now[:error] = t(".score_error")
      render 'edit'
    end
  end

  def create
    @match = Match.new(match_attributes)

    if @match.save
      flash[:success] = t(".success")
      redirect_to '/matches'
    else
      flash.now[:error] = t(".error")
      render 'new'
    end
  end

   def destroy
    @match = Match.find(params[:id])
    if @match.destroy
      flash[:success] = t(".success")
    else
      flash[:error] = t(".error")
    end

    redirect_to matches_path
  end

  private

  def match_attributes
    params[:match].permit(:start_date, :home_team_id, :away_team_id, :home_team_goals, :away_team_goals, :play_off, :penalities)
  end
end
