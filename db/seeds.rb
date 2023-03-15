# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

user = User.find_or_create_by!(email: 'uno@test.test') { |u| u.password = '123456' }
guest = User.find_or_create_by!(email: 'guest@test.test') { |u| u.password = '123456' }
host = User.find_or_create_by!(email: 'host@test.test') { |u| u.password = '123456' }

locations = {
  "Paris" => {
    "titre" => "Chambre sur les Champs-Élysées",
    "adresse" => "Champs-Élysées, 75008 Paris",
    "description" => "Chambre élégante et confortable sur l'avenue mythique de la capitale française, bordée d'arbres, de boutiques de luxe et de cafés"
  },
  "Marseille" => {
    "titre" => "Studio au Vieux-Port",
    "adresse" => "Vieux-Port, 13001 Marseille",
    "description" => "Studio confortable avec vue sur le port historique de la ville, bordé de cafés et de restaurants de fruits de mer"
  },
  "Lyon" => {
    "titre" => "Appartement Place Bellecour",
    "adresse" => "Place Bellecour, 69002 Lyon",
    "description" => "Appartement spacieux et lumineux avec vue sur la grande place publique au centre de Lyon, avec une statue équestre de Louis XIV"
  },
  "Toulouse" => {
    "titre" => "Chambre Place du Capitole",
    "adresse" => "Place du Capitole, 31000 Toulouse",
    "description" => "Chambre confortable et lumineuse avec vue sur la place centrale de la ville, bordée de bâtiments historiques, de boutiques et de restaurants"
  },
  "Nice" => {
    "titre" => "Chambre sur la Promenade des Anglais",
    "adresse" => "Promenade des Anglais, 06000 Nice",
    "description" => "Chambre confortable avec vue sur le bord de mer animé de Nice, avec des restaurants, des cafés et une vue sur la Méditerranée"
  },
  "Nantes" => {
    "titre" => "Appartement moderne sur l'Île de Nantes",
    "adresse" => "Île de Nantes, 44200 Nantes",
    "description" => "Appartement moderne et spacieux dans une ancienne zone portuaire reconvertie en un quartier moderne avec des œuvres d'art contemporain"
  },
  "Strasbourg" => {
    "titre" => "Chambre dans le quartier historique de la Petite France",
    "adresse" => "Petite France, 67000 Strasbourg",
    "description" => "Chambre confortable dans le quartier historique de la ville, avec des maisons à colombages, des rues pavées et des canaux"
  },
  "Montpellier" => {
    "titre" => "Chambre sur la Place de la Comédie",
    "adresse" => "Place de la Comédie, 34000 Montpellier",
    "description" => "Chambre élégante avec vue sur la grande place piétonne de la ville, avec des cafés, des boutiques et un opéra"
  },
  "Bordeaux" => {
    "titre" => "Chambre avec vue sur la Place de la Bourse",
    "adresse" => "Place de la Bourse, 33000 Bordeaux",
    "description" => "Chambre confortable avec vue sur la place historique de la ville, avec une fontaine et une vue sur la Garonne"
  }
  }

  locations_spain = {
    "Barcelone" => {
      "titre" => "Appartement dans le quartier gothique",
      "adresse" => "Carrer de la Ciutat, 08002 Barcelona",
      "description" => "Appartement confortable situé dans le quartier gothique de Barcelone, avec ses rues étroites et ses bâtiments historiques"
    },
    "Madrid" => {
      "titre" => "Appartement sur la Gran Via",
      "adresse" => "Gran Via, Madrid, 28013",
      "description" => "Appartement élégant avec vue sur la célèbre Gran Via de Madrid, à proximité des attractions touristiques telles que le Palais royal et le musée du Prado"
    }
  }
french_host = User.find_or_create_by(email: "french_host@test.test") { |u| u.password = '123456' }
locations.each do |city, location|
  Room.create( user_id: french_host.id,
    title: location["titre"],
    description: location["description"],
    price: rand(50..500),
    room_type: rand(0..3),
    city: city,
    country: "France",
    address: location["adresse"])
end

locations_spain.each do |city, location|
  Room.create( user_id: user.id,
    title: location["titre"],
    description: location["description"],
    price: rand(50..500),
    room_type: rand(0..3),
    city: city,
    country: "Espagne",
    address: location["adresse"])
end

Booking.create(
  checkin: Date.new(2023,03, 01),
  checkout: Date.new(2023,03, 03),
  room_id: Room.first.id,
  user_id: user.id,
  total_price: Room.first.price * 2
)

Booking.create(
  checkin: Date.new(2023,04, 01),
  checkout: Date.new(2023,04, 03),
  room_id: Room.last.id,
  user_id: user.id,
  total_price: Room.last.price * 2
)


guests = []
5.times do |index|
  guests << User.find_or_create_by(email: "guest#{index}@test.test") { |u| u.password = '123456' }
end 

Room.where(country: 'France').each do |room|
  sum = 0
  guests.each do |guest|
    sum += 2
    Booking.create(
      checkin: Date.new(2023,03, 01) + sum,
      checkout: Date.new(2023,03, 03) + sum,
      room_id: room.id,
      user_id: guest.id,
      total_price: room.price * 2
    )
  end
end

Room.all.each do |room|
  file = File.join("app/assets/images/#{room.city.downcase}.jpg")
  if File.exist?(file)
    room.image.attach(io: File.open(file), filename:"#{room.city.downcase}.jpg")
  else
    room.image.attach(io: File.open("app/assets/images/pic.jpg"), filename:"pic.jpg")
  end
end


guests.each do |guest|
  guest.bookings.each do |booking|
    booking.room.reviews.create(review_type: 1, comment: 'Super Chambre, propre et lumineux!', rating: 5, writer_id: guest.id)
    booking.user.reviews.create(review_type: 0, comment: 'Très bon invité très sympa!', rating: 5, writer_id: booking.room.user_id)
  end
end

