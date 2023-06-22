class Room < ApplicationRecord

  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many_attached :images

  validates :name, presence: true

  geocoded_by :address

  monetize :price_per_night_cents, numericality: {
    greater_than_or_equal_to: 0
  }

  after_validation :geocode

  scope :free, lambda { |check_in, check_out|
    left_joins(:reservations)
      .where('reservations.check_in > ? OR reservations.check_out <= ? OR reservations.id IS NULL', check_out, check_in)
  }

end
