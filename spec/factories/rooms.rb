FactoryBot.define do
  factory :room do
    sequence(:name) { |n| "Room #{n}" }
    location { 'Some location' }
    capacity { 2 }
    price_per_night_cents { 100_00 }
    association :user
  end
end
