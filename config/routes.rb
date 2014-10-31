Rails.application.routes.draw do

  scope '/:store_slug' do
    get"/photos",       to: 'items#index', as: "photos"
    get "/about",       to: "pages#about", as: 'about'
    get "/photo/:id",   to: "items#show",  as: 'photo'
    get "/home",        to: "pages#menu",  as: 'home'
    get  '/login',      to: 'sessions#new'
    post '/login',      to: 'sessions#create'
    get    '/logout',   to: 'sessions#destroy'
    get 'users/:id/orders', to: 'users#orders', as: 'user_orders'
    get '/cart'   => 'pages#cart_route', as: 'cart'
    get '/code'   => 'pages#code'
    get '/admin'  => 'pages#admin'
    resources :users
    resources :orders
    resources :items, only: [:index, :show]
    resources :categories
    resources :addresses, only: [:create]
    resources :line_items
    resources :charges

    namespace :admin do
      resources :users, only: [:destroy]
      resources :items
      resources :categories
    end
  end
end
