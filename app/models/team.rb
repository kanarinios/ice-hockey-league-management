class Team < ActiveRecord::Base
  has_many :players
  has_many :memberships

  has_attached_file :logo, :styles => { :icon => "32x32>" }, :default_url => "/images/:style/missing.jpg"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
end
