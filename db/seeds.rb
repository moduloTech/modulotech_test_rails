# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

User.find_or_create_by!(email: 'uno@test.test') { |u| u.password = '123456' }
guest = User.find_or_create_by!(email: 'guest@test.test') { |u| u.password = '123456' }
host = User.find_or_create_by!(email: 'host@test.test') { |u| u.password = '123456' }
require 'faker'
require 'geocoder'

# Création de 20 utilisateurs avec des adresses e-mail aléatoires

hosts = []
10.times do |index|
  hosts << User.find_or_create_by(email: "host#{index}@test.test") { |u| u.password = '123456' }
end

guests = []
30.times do |index|
  guests << User.find_or_create_by(email: "guest#{index}@test.test") { |u| u.password = '123456' }
end 

hosts.each do |host|
  location = Geocoder.search('Paris, France', params: { category: 'touristic', lang: 'fr', min_confidence: 0.6, max_rows: 5, 'rating.min': 4.5 }).sample
  room = Room.create(
    user_id: host.id,
    title: location.address,
    description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
    price: rand(50..500),
    room_type: rand(0..3),
    city: location.city,
    country: location.country,
    address: location.address)
end

guests.each do |guest|
  room = Room.all.sample
  Booking.create(
    checkin: Faker::Date.between(from: 1.week.ago, to: Date.today),
    checkout: Faker::Date.between(from: Date.tomorrow, to: 1.week.from_now),
    room_id: room.id,
    user_id: guest.id
  )
end

guests.each do |guest|
  guest.bookings.each do |booking|
    booking.room.reviews.create(review_type: 1, comment: 'Super Chambre, propre et lumineux!', rating: 5, writer_id: guest.id)
    booking.user.reviews.create(review_type: 0, comment: 'Très bon invité très sympa!', rating: 5, writer_id: booking.room.user_id)
  end
end