class Room < ApplicationRecord

  has_one_attached :image
  has_many_attached :gallery_images
  has_rich_text :description

  belongs_to :user
  has_many :reservations, dependent: :destroy

  validates :name, :location, presence: true
  validates :capacity, presence: true, numericality: { greater_than: 0 }
  validates :price_per_night_cents, presence: true, numericality: { greater_than: 0 }

  scope :not_reserved, lambda { |start_date, end_date|
                         where.not(id: Reservation.reserved(start_date, end_date).select(:room_id))
                       }
  scope :by_location, ->(location) { where(location:) }

  def reserved?(start_date, end_date)
    !id.in?(Reservation.reserved(start_date, end_date).pluck(:room_id))
  end

end
