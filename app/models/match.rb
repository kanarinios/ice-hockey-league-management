class Match < ActiveRecord::Base
  belongs_to :home_team, class_name:"Team"
  belongs_to :away_team, class_name:"Team"

  def scores_present?
    self.home_team_goals.present? && self.away_team_goals.present?
  end
end
