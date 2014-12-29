module Teams
  class TableUpdateService

    def self.update_points(match)
      update_policy = Match::UpdatePolicy.new(match)

      if update_policy.home_team_winner?
        match.winner = match.home_team_id
      elsif update_policy.away_team_winner?
        match.winner = match.away_team_id
      elsif update_policy.draw?
        match.winner = 0
      end
      match.save
    end
  end
end
