# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

User.find_or_create_by!(email: 'uno@test.test') { |u| u.password = '123456' }
User.find_or_create_by!(email: 'duo@test.test') { |u| u.password = '123456' }
User.find_or_create_by!(email: 'trio@test.test') { |u| u.password = '123456' }

# TODO: Add a room owned by uno
# TODO: Add a room owned by duo
