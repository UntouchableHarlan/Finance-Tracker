Rails.application.routes.draw do
  root 'welcome#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  get '/my_portfolio' => 'users#my_portfolio'
  get '/get_stocks' => 'stocks#search'

  resources :sessions
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
