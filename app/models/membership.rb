class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validates  :role,
             presence: true,
             inclusion: { in: User::ROLES.values }
end
