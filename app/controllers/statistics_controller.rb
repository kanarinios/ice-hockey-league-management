class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  private

  def player_attributes
    params[:player].permit(:first_name, :last_name, :date_of_birth, :weight, :height, :country, :team_id, :photo)
  end
end
