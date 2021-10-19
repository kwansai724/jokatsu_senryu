class Voter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :likes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  validates :name, presence: true
  validates :group, presence: true
end
