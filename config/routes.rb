Rails.application.routes.draw do
  devise_for :users
  # health_check_routes # TODO: remove this comment before release

  root "rooms#index"

  resources :rooms, only: %i[index show]
end
