class Booking < ApplicationRecord

  belongs_to :room
  belongs_to :user

  scope :booked_between, ->(check_in, check_out) { where('checkin > ? AND checkout < ?', check_in, check_out) }
  scope :past, -> { where('checkout < :date_today', date_today: Time.zone.today) }
  scope :current, -> { where('checkout >= :date_today', date_today: Time.zone.today) }

end
