# frozen_string_literal: true

FactoryBot.define do
  factory :reservation, class: 'Reservation' do
    association :user
    association :room
    check_in { Time.current }
    check_out { Time.current + 20.days }
  end
end

