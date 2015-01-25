class PlayersController < ApplicationController
  def index
    if params[:query].present?
      @players = Player.search(params[:query])
    else
      @players = Player.all
    end
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
      flash[:success] = t(".success")
      redirect_to '/players'
    else
      flash.now[:error] = t(".error")
      render 'edit'
    end
  end

  def create
    @player = Player.new(player_attributes)

    if @player.save
      flash[:success] = t(".success")
      redirect_to '/players'
    else
      flash.now[:error] = t(".error")
      render 'new'
    end
  end

   def destroy
    @player = Player.find(params[:id])
    if @player.destroy
      flash[:success] = t(".success")
    else
      flash.now[:error] = t(".error")
    end

    redirect_to players_path
  end

  private

  def player_attributes
    params[:player].permit(:first_name, :last_name, :date_of_birth, :weight, :height, :country, :team_id, :photo)
  end
end
