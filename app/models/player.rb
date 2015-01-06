class Player < ActiveRecord::Base
  belongs_to :team

  has_attached_file :photo, styles: { icon: "32x32>", medium: "300x300>" }, default_url: "/images/missing_:style.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
