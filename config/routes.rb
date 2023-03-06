Rails.application.routes.draw do
  devise_for :users
  health_check_routes

  root 'rooms#index'

  resources :rooms, only: %i[index show] do
    resources :reservations, module: :users, only: :create
  end

  scope :my, as: :my do
    resources :rooms, module: :users do
      resources :images, only: :destroy
    end

    resources :reservations, module: :users, only: %i[index edit update destroy]
  end
end
