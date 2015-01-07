class Team < ActiveRecord::Base
  has_many :players, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :matches, dependent: :destroy

  has_attached_file :logo, styles: { icon: "32x32>", medium: "300x300>" }, default_url: "/images/missing_:style.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: true

  def points
    3*wins + draws
  end

  def wins
    ended_matches.where("winner = ?", id).count
  end

  def draws
    ended_matches.where("winner = ?", 0).count
  end

  def lost
    ended_matches.where("winner != ?", id).count
  end

  def ended_matches
    matches.where("home_team_goals IS NOT NULL AND away_team_goals IS NOT NULL")
  end

  private

  def matches
    Match.where("home_team_id = ? OR away_team_id = ?", id, id)
  end
end
