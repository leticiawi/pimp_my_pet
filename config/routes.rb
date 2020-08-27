Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :new, :create, :destroy, :index]
  resources :carts, only: [:destroy, :show, :index]
  resources :products do
  resources :carts, only: [:create, :new ]
  resources :orders, only: [:show, :create, :new] do
    resources :payments, only: :new
    end
  end

  mount StripeEvent::Engine, at: '/stripe-webhooks'

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
