# TODO: Add features to this model to implement the other TODO.
class Room < ApplicationRecord
  has_many :bookings
  has_many :reviews, :as => :reviewable
  belongs_to :user 

  enum room_type: [ :Appartement, :Maison, :Chambre, :Villa ]

end
