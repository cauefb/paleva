Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :establishments, only: [:show, :new, :create,:edit, :update] do
    #resources :opening_hours, only: [:show, :new, :create,:edit,:update]
  end
end
