# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# load the correct seeds file for our Rails environment
load(Rails.root.join('db', 'seeds', "#{Rails.env.downcase}.rb"))
