class User < ActiveRecord::Base

  has_many :memberships, dependent: :destroy

  ROLES = {
    team_owner: 1,
    player: 2,
    league_manager: 3
  }.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Roles checking methods:
  def team_owner?(team)
    has_role? :team_owner, team.id
  end

  def player?(team)
    has_role? :player, team.id
  end

  def league_manager?
    has_role? :league_manager, nil
  end

  def has_role?(*roles, team_id)
    membership = self.memberships.where(team_id: team_id).first
    roles_ids = roles.map { |r| User::ROLES[r.to_sym] }
    !!(membership && roles_ids.include?(membership.role))
  end
end
