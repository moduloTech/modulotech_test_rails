class Review < ApplicationRecord

  belongs_to :reviewable, polymorphic: true
  enum review_type: { from_host: 0, from_guest: 1 }

end
