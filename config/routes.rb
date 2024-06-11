Rails.application.routes.draw do
  devise_for :users
  health_check_routes

  root "rooms#index"

  resources :rooms, only: %i[index show]
  namespace :my do
    resources :rooms, only: %i[index show edit new create update destroy] do
      member do
        delete :remove_image
      end
    end

    resources :reservations, only: %i[index create destroy]do
      member do
        put :confirmed
      end
    end
  end
end
