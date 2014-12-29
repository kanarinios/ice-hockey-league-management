class TableController < ApplicationController
  def index
    @teams = Team.order(points: :desc)
  end
end
