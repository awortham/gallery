Rails.application.routes.draw do
  resources :line_items
  resources :charges

  scope '/:store_slug' do
    get"/photos", to: 'items#index', as: "photos"
    get "/about", to: "pages#about", as: 'about'
    get "/photo/:id", to: "items#show", as: 'photo'
    get "/home", to: "pages#menu", as: 'home'
  end

  # get "/:store_slug/photos", to: "items#index", as: 'photos'
  # get "/:store_slug/cart", to: "carts#show"

  get '/menu'   => 'pages#menu'
  get '/admin'  => 'pages#admin'
  get '/cart'   => 'pages#cart_route', as: 'cart'
  get 'about'   => 'pages#about'
  get '/code'   => 'pages#code'
  get '/photos' => 'items#index'

  resources :users
  resources :items, only: [:index, :show]
  resources :categories
  resources :orders
  resources :addresses, only: [:create]

  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  get    '/logout',   to: 'sessions#destroy'
  get    'users/:id/orders', to: 'users#orders', as: 'user_orders'

  namespace :admin do
    resources :users, only: [:destroy]
    resources :items
    resources :categories
  end
end
