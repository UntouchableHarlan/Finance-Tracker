Rails.application.routes.draw do
  root 'welcome#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  get '/my_portfolio' => 'users#my_portfolio'
  get '/get_stocks' => 'stocks#search'
  get '/get_friends' => 'users#search'

  get '/create_stock' => 'stocks#create'
  get '/create_friendship' => 'users#add_friend'

  get '/connect' => 'users#connect'

  resources :sessions
  resources :users
  resources :stocks, only: [:destroy]
  resources :friendships, only: [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
