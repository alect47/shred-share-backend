Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :sessions, only: [:create]

  # post 'auth/register', to: 'users#register'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#is_logged_in?'

  resources :users, only: [:create, :show, :index]
  resources :vehicles, only: [:create, :index, :show]

  namespace :user do
    resources :vehicles, only: [:index]
  end


end
