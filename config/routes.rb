Rails.application.routes.draw do
  resources :line_items
  resources :charges

  root 'pages#menu'

  get '/menu'   => 'pages#menu'
  get '/admin'  => 'pages#admin'
  get '/cart'   => 'pages#cart_route', as: 'cart'
  get '/about'  => 'pages#about'
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
