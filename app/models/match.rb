class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"
  has_many :scores, dependent: :destroy

  validate :cannot_be_the_same, on: :create
  validates :away_team_id, presence: true
  validates :home_team_id, presence: true
  validates :start_date, presence: true
  validate :cannot_be_draw, on: :update
  validates :away_team_goals, presence: true, on: :update
  validates :home_team_goals, presence: true, on: :update

  accepts_nested_attributes_for :scores


  searchkick

  def search_data
    {
      home_team_name: home_team(&:name),
      away_team_name: away_team(&:name)
    }
  end

  def scores_present?
    self.home_team_goals.present? && self.away_team_goals.present?
  end

  def results
    {home_team_goals: home_team_goals, away_team_goals: away_team_goals}
  end

  def players
    home_team.players + away_team.players
  end

  private

  def cannot_be_draw
    if home_team_goals == away_team_goals
      errors.add(:home_team_goals, 'Nie możesz dodać remisu.')
      errors.add(:away_team_goals, 'Nie możesz dodać remisu.')
    end
  end

  def cannot_be_the_same
    if Match.where(home_team_id: home_team_id, away_team_id: away_team_id).present?
      errors.add(:home_team_id, 'Nie możesz dodać spotkania. Istnieje już w systemie.')
      errors.add(:away_team_id, 'Nie możesz dodać spotkania. Istnieje już w systemie.')
    elsif home_team_id == away_team_id
      errors.add(:home_team_id, 'Nie możesz dodać spotkania z identycznymi drużynami.')
      errors.add(:away_team_id, 'Nie możesz dodać spotkania z identycznymi drużynami.')
    end
  end
end
