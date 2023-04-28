# TODO: Add features to this model to implement the other TODO.
class Room < ApplicationRecord

  belongs_to :user
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  has_many :reservations, dependent: :destroy
  has_many_attached :images

  validates :price, presence: true

  def self.free_on(start_date, end_date)
    reserved_room_ids = Reservation
                        .where('reservations.end_date >= ? AND reservations.start_date <= ?', start_date, end_date)
                        .pluck('DISTINCT room_id')
    where.not(id: reserved_room_ids)
  end

end
