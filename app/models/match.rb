class Match < ActiveRecord::Base
  belongs_to :home_team, class_name:"Team"
  belongs_to :away_team, class_name:"Team"

  validates :away_team, presence: true
  validates :home_team, presence: true

  def scores_present?
    self.home_team_goals.present? && self.away_team_goals.present?
  end

  def scores
    {home_team_goals: home_team_goals, away_team_goals: away_team_goals}
  end
end
