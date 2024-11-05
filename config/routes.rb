Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :establishments, only: [:show, :new, :create,:edit, :update] do
    resources :dishes, only: [:index, :show, :new, :create,:edit,:update, :destroy] do
      post 'enabled', on: :member
      post 'disabled', on: :member
    end
    resources :beverages, only: [:index, :show, :new, :create,:edit,:update, :destroy] do
      post 'enabled', on: :member
      post 'disabled', on: :member
    end
  end
  get 'search', to: 'search#search'
end