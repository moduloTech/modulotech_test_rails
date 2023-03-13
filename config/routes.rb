Rails.application.routes.draw do
  devise_for :users
  health_check_routes

  root "rooms#index"
  resources :rooms do
    resources :bookings, only: [:create]
  end
  resources :bookings, only:[:destroy]
  get 'my_rooms', to: 'rooms#user_rooms'
  get 'my_bookings', to: 'bookings#user_bookings'
end
