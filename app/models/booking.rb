class Booking < ApplicationRecord

  belongs_to :room
  belongs_to :user

  scope :booked_between, lambda { |checkin, checkout|
                           where('checkin > ? AND checkout < ?', checkin, checkout)
                         }
  scope :past, -> { where('checkout < :date_today', date_today: Time.zone.today) }
  scope :current, -> { where('checkout >= :date_today', date_today: Time.zone.today) }

end
