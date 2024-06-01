class Room < ApplicationRecord
  has_one_attached :image
  has_many_attached :gallery_images
  has_rich_text :description

  belongs_to :user
end
