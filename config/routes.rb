Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  get '/checkout', to: 'checkout#show', as: 'checkout'
  get '/order_placed', to: 'checkout#order_placed', as: 'order_placed'


  post '/apply_promo_code', to: 'checkout#apply_promo_code', as: 'apply_promo_code'
  post '/checkout', to: 'checkout#create'

  resources :users
  resources :products, only: [:index, :show, :new, :create]
  resources :cart_items, only: [:create, :update]
  resource :cart, only: [:show] 
  resource :checkout, only: [:show, :create ]
  resources :comments, only: [:create]
  root 'products#index'
  # root "posts#index"
end
