Rails.application.routes.draw do

  root 'ideas#index'

  resources :ideas

  resources :users, only: [:new, :create]

  resource :session, only: [:new, :create, :destroy]
end
