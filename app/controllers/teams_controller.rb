class TeamsController < ApplicationController

  def index
    if params[:query].present?
      @teams = Team.search(params[:query])
    else
      @teams = Team.all
    end
  end

  def new
    @team = Team.new
  end

  def edit
    @team = Team.find(params[:id])
  end

  def show
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])

    if @team.update(team_attributes)
      flash[:success] = t(".success")
      redirect_to teams_path
    else
      flash[:error] = t(".error")
      render edit_teams_path
    end
  end

  def create
    @team = Team.new(team_attributes)

    if @team.save
      flash[:success] = t(".success")
      redirect_to teams_path
    else
      flash[:error] = t(".error")
      render new_team_path
    end
  end

   def destroy
    @team = Team.find(params[:id])
    if @team.destroy
      flash[:success] = t(".success")
    else
      flash[:error] = t(".error")
    end
    redirect_to teams_path
  end

  private

  def team_attributes
    params[:team].permit(:name, :description, :logo)
  end
end
