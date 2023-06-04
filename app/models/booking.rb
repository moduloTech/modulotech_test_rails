class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :from, :to, presence: true
end
