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
    resources :menus, only: [:new, :create, :index, :show, :update] do
      member do
        delete 'remove_dish'
        delete 'remove_beverage'
      end
    end
    
  end

  resources :dishes, only: [] do
    resources :portions, only: [:index, :show, :new, :create, :edit, :update]
  end
  
  resources :beverages, only: [] do
    resources :portions, only: [:index, :show, :new, :create, :edit, :update]
  end
  resources :orders do
    # collection do
    #   get 'select_items', to: 'orders#select_items'
    # end
    member do
      get :select_items
      post :add_item
      get 'select_portion'
      patch :finalize
    end
  end
  resources :tags
  
  resources :order_items, only: [:destroy]

  resources :employees, only: [:index, :new, :create]

  get 'search', to: 'search#search'

  namespace :api do
    namespace :v1 do
      resources :establishments, param: :code, only: [] do
        resources :orders, param: :order_code, only: [:index, :show, :update] do
          member do
            patch :accept
            patch :ready
          end
        end
      end
    end
  end
end