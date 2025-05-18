class Store < ApplicationRecord
  belongs_to :owner, class_name: 'User', optional: true
  has_many :ratings, dependent: :destroy
  
  validates :name, presence: true, length: { minimum: 10, maximum: 60 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }
  validates :address, presence: true, length: { maximum: 400 }
  
  def average_rating
    ratings.average(:value) || 0
  end
end
