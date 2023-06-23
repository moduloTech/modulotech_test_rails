Rails.application.routes.draw do
  devise_for :users
  health_check_routes

  root "rooms#index"

  resources :rooms, only: %i[index show]

  namespace :my do
    resources :rooms
    resources :reservations
  end
end
