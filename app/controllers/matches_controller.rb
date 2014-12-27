class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def new
    @match = Match.new
  end

  def edit
    @match = Match.find(params[:id])
  end

  def show
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])

    if @match.update(match_attributes)
      redirect_to '/matches'
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
    params[:match].permit(:start_date, :home_team_id, :away_team_id)
  end
end
