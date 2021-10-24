class Voter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :voterposts, through: :likes
  has_many :likes
  has_many :favorites, through: :likes, source: :post

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  validates :name, presence: true
  validates :group, presence: true

  # def like_this(clicked_post)
  #   self.likes.find_or_create_by(post: clicked_post)
  # end
end
