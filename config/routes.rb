Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :sessions, only: [:create]

  # post 'auth/register', to: 'users#register'
  resources :users, only: [:create, :show, :index]


end
