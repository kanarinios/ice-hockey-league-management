class Team < ActiveRecord::Base
  has_many :players
  has_many :memberships

  has_attached_file :logo, styles: { icon: "32x32>", medium: "300x300>" }, default_url: "/images/missing_:style.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
end
