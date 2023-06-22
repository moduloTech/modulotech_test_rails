# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
User.destroy_all
Room.destroy_all
Reservation.destroy_all

user1 = User.create(email: 'uno@test.test') { |u| u.password = '123456' }
user2 = User.create(email: 'duo@test.test') { |u| u.password = '123456' }
user3 = User.create(email: 'trio@test.test') { |u| u.password = '123456' }

Room.create(user_id: user1.id, name: "Luxury apartment", price_per_night_cents: 50000, price_per_night_currency: 'EUR', address: 'Mayfair, London')
Room.create(user_id: user1.id, name: "Not so good apartment", price_per_night_cents: 20000, price_per_night_currency: 'EUR', address: 'Berlin, Germany')
Room.create(user_id: user2.id, name: "Good apartment", price_per_night_cents: 40000, price_per_night_currency: 'EUR', address: 'Tekelijina, Novi Sad, Serbia')
Room.create(user_id: user2.id, name: "Super apartment", price_per_night_cents: 50000, price_per_night_currency: 'EUR', address: 'Mayfair, London')

Reservation.create(user: user3, room: Room.last, check_in: Time.current, check_out: Time.current + 10.days)