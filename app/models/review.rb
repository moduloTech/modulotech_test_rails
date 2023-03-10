class Review < ApplicationRecord
  belongs_to :reviewable, :polymorphic => true
  enum review_type: [ :from_host, :from_guest ]
end
