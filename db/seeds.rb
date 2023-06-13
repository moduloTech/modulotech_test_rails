# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

uno_user = User.find_or_create_by!(email: 'uno@test.test') { |u| u.password = '123456' }
duo_user = User.find_or_create_by!(email: 'duo@test.test') { |u| u.password = '123456' }
User.find_or_create_by!(email: 'trio@test.test') { |u| u.password = '123456' }

Room.create!(name: 'Italiano', location: 'Milan', description: 'Pasta del maro', price_cents: 1500000, price_currency: 'USD', user: uno_user)
Room.create!(name: 'Madrid Spa Resort', location: 'Madrid', description: 'spain spain spain', price_cents: 500000, price_currency: 'USD', user: duo_user)
