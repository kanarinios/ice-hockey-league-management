class TeamsController < ApplicationController

  def index
    @teams = Team.all
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
      redirect_to '/teams'
    else
      render 'edit'
    end
  end

  def create
    @team = Team.new(team_attributes)

    if @team.save
      redirect_to '/teams'
    else
      render 'new'
    end
  end

   def destroy
    @team = Team.find(params[:id])
    @team.destroy

    redirect_to teams_path
  end

  private

  def team_attributes
    params[:team].permit(:name, :description, :logo)
  end
end
