class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :store

  validates :value, presence: true, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :store_id, message: "can only rate a store once" }
end