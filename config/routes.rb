Rails.application.routes.draw do
  health_check_routes

  root "rooms#index"

  resources :rooms, only: %i[index show]
end
