class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   enum role: { normal_user: 0, store_owner: 1, system_admin: 2 }
  
  validates :name, presence: true, length: { minimum: 10, maximum: 60 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }
  validates :address, length: { maximum: 400 }
  
  has_many :ratings, dependent: :destroy
  has_many :stores, foreign_key: 'owner_id', dependent: :nullify, inverse_of: :owner
end
