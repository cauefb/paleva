Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :establishments, only: [:show, :new, :create,:edit, :update] do
    resources :dishes, only: [:index, :show, :new, :create,:edit,:update, :destroy] do
      post 'enabled', on: :member
      post 'disabled', on: :member
      post 'add_tag', on: :member
      delete 'remove_tag', on: :member
    end
    resources :beverages, only: [:index, :show, :new, :create,:edit,:update, :destroy] do
      post 'enabled', on: :member
      post 'disabled', on: :member
    end
  end

  resources :dishes, only: [] do
    resources :portions, only: [:index, :show, :new, :create, :edit, :update]
  end
  
  resources :beverages, only: [] do
    resources :portions, only: [:index, :show, :new, :create, :edit, :update]
  end

  resources :tags

  get 'search', to: 'search#search'
end