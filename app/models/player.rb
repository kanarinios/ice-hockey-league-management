class Player < ActiveRecord::Base
  belongs_to :team
  has_many :scores

  has_attached_file :photo, styles: { icon: "32x32>", medium: "300x300>" }, default_url: "/images/missing_:style.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :team, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_name_with_team
    "#{full_name} (#{team.name})"
  end

  #Funkcja #goals obliczająca bramki, powinna uwzględniać samobóje.TODO:
  def goals
    scores.count
  end
end
