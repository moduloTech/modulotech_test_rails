class Booking < ApplicationRecord
  scope :booked, -> (from, to) { where(to: from.., from: ..to) }

  belongs_to :room
  belongs_to :user

  validates :from, :to, presence: true
end
