class Match::UpdatePolicy

  def initialize(match, old_scores=nil)
    self.match, self.old_scores = match, old_scores
  end

  def scores_present?
    match.home_team_goals.present? && match.away_team_goals.present?
  end

  def result_changed?
    if old_scores.present?
      if old_away_team_winner?
        home_team_winner? || draw?
      elsif old_home_team_winner?
        away_team_winner? || draw?
      elsif old_draw?
        !draw?
      end
    else
      true
    end
  end

  def home_team_winner?
    match.home_team_goals > match.away_team_goals
  end

  def away_team_winner?
    match.home_team_goals < match.away_team_goals
  end

  def draw?
    match.home_team_goals == match.away_team_goals
  end

  def old_home_team_winner?
    old_scores[:home_team_goals] > old_scores[:away_team_goals]
  end

  def old_away_team_winner?
    old_scores[:home_team_goals] < old_scores[:away_team_goals]
  end

  def old_draw?
    old_scores[:home_team_goals] = old_scores[:away_team_goals]
  end

  private

  attr_accessor :match, :old_scores

end
