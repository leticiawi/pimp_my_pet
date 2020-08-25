Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :new, :create, :destroy, :index] do
  resources :products, only: [:show, :index, :new, :create, :destroy]
  resources :cart, only: [:new, :create, :destroy]
end
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
