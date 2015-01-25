class Team < ActiveRecord::Base
  has_many :players, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :home_matches, class_name: 'Match', foreign_key: 'home_team_id', dependent: :destroy
  has_many :away_matches, class_name: 'Match', foreign_key: 'away_team_id', dependent: :destroy

  has_attached_file :logo, styles: { icon: "32x32>", medium: "300x300>" }, default_url: "/images/missing_:style.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: true

  searchkick

  def points
    3*wins_after_3_thirds + 2*wins_after_play_off_or_penalities + lost_after_play_off_or_penalities
  end

  def wins_after_3_thirds
    won_matches.select {|m| m[:play_off] == false && m[:penalities] == false}.count
  end

  def wins_after_play_off_or_penalities
    won_matches.select {|m| m[:play_off] == true || m[:penalities] == true}.count
  end

  def lost_after_play_off_or_penalities
    lost_matches.select {|m| m[:play_off] == true || m[:penalities] == true}.count
  end

  def won_matches
    ended_matches.select {|m| m[:winner] == id}
  end

  def lost_matches
    ended_matches.select {|m| m[:winner] != id && m[:winner] != nil}
  end

  def ended_matches
    matches.select {|m| m[:home_team_goals] != nil || m[:away_team_goals] != nil}
  end

  def not_played_matches
    matches.select {|m| m[:home_team_goals] == nil || m[:away_team_goals] == nil}
  end

  def matches
    home_matches + away_matches
  end

  private
end
