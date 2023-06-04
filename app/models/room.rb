# TODO: Add features to this model to implement the other TODO.
class Room < ApplicationRecord
  has_many_attached :images do |img|
    img.variant :thumbnail, resize_to_limit: [400, 400]
  end
end
