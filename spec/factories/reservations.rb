FactoryBot.define do
  factory :reservation do
    association :user
    association :room
    start_date { Time.zone.today }
    end_date { Time.zone.today + 1 }
    status { Reservation::STATUS[:confirmed] }
    price_cents { Faker::Number.between(from: 100_00, to: 999_00) }
  end
end
