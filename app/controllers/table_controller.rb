class TableController < ApplicationController
  def index
    @teams = Team.all.sort_by {|team| team.points }.reverse
  end
end
