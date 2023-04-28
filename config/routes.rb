Rails.application.routes.draw do
  devise_for :users
  health_check_routes

  root "rooms#index"

  resources :rooms
  resources :reservations, only: %i[create destroy]

  get '/my/reservations' => 'reservations#index', as: :my_reservations
  get '/my/rooms' => 'rooms#my_rooms', as: :my_rooms
end
