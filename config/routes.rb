Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :new, :create, :destroy, :index]
  resources :carts, only: [:destroy, :show, :index]
  resources :products do
    resources :carts, only: [:create, :new ]
  end

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
