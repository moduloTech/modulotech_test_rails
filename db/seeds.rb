# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

first_user = User.find_or_create_by!(email: 'uno@test.test') { |u| u.password = '123456' }
second_user = User.find_or_create_by!(email: 'duo@test.test') { |u| u.password = '123456' }

4.times do |i|
  first_user.rooms.find_or_create_by!(
    name: "Room 1#{i}",
    location: "Location 1#{i}",
    price_per_night: (i + 1) * 100,
    start_date: Date.current + i.days,
    end_date: Date.current + (10 + i).days
  )

  second_user.rooms.find_or_create_by!(
    name: "Room 2#{i}",
    location: "Location 2#{i}",
    price_per_night: (i + 1) * 200,
    start_date: Date.current + i.days,
    end_date: Date.current + (20 + i).days
  )
end
