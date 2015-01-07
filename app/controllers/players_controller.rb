class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def edit
    player = Player.find(params[:id])
    @player = PlayerPresenter.new(player)
  end

  def show
    player = Player.find(params[:id])
    @player = PlayerPresenter.new(player)
  end

  def update
    @player = Player.find(params[:id])

    if @player.update(player_attributes)
      redirect_to '/players'
    else
      render 'edit'
    end
  end

  def create
    @player = Player.new(player_attributes)

    if @player.save
      redirect_to '/players'
    else
      render 'new'
    end
  end

   def destroy
    @player = Player.find(params[:id])
    @player.destroy

    redirect_to players_path
  end

  private

  def player_attributes
    params[:player].permit(:first_name, :last_name, :date_of_birth, :weight, :height, :country, :team_id, :photo)
  end
end
