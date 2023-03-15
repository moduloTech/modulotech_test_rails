# TODO: Add features to this model to implement the other TODO.
class Room < ApplicationRecord

  has_many :bookings, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  belongs_to :user

  enum room_type: { Appartement: 0, Maison: 1, Chambre: 2, Villa: 3 }

  def calculate_average_rating
    return 0 if reviews.count.zero?

    reviews.pluck(:rating).sum / reviews.count
  end

end
