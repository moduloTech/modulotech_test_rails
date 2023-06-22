# frozen_string_literal: true

FactoryBot.define do
  factory :room, class: 'Room' do
    name { 'Comfortable luxury room' }
    price_per_night_cents { 500 }
    price_per_night_currency { 'USD' }
    address { 'Mayfair, London' }
  end
end
