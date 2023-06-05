# TODO: Add features to this model to implement the other TODO.
class Room < ApplicationRecord
  scope :booked, ->(from, to) { where(id: Booking.booked(from,to)) }
  scope :not_booked, ->(from, to) { where.not(id: Booking.booked(from,to)) }

  monetize :price_cents

  has_many_attached :images do |img|
    img.variant :thumbnail, resize_to_limit: [400, 400]
  end

  def can_book?(from, to)
    !id.in? Booking.booked(from,to).pluck(:room_id)
  end
end
