class Room < ApplicationRecord

  has_one_attached :image
  has_many_attached :gallery_images
  has_rich_text :description

  belongs_to :user

  validates :name, :location, presence: true
  validates :capacity, presence: true, numericality: { greater_than: 0 }
  validates :price_per_night_cents, presence: true, numericality: { greater_than: 0 }

end
