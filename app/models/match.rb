class Match < ActiveRecord::Base
  belongs_to :home_team, class_name:"Team"
  belongs_to :away_team, class_name:"Team"
  has_many :scores, dependent: :destroy

  validates :away_team_id, presence: true
  validates :home_team_id, presence: true
  validates :start_date, presence: true

  accepts_nested_attributes_for :scores

  def scores_present?
    self.home_team_goals.present? && self.away_team_goals.present?
  end

  def results
    {home_team_goals: home_team_goals, away_team_goals: away_team_goals}
  end

  def players
    home_team.players + away_team.players
  end
end
