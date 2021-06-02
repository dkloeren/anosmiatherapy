Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/profile', to: 'pages#profile', as: 'profile'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/countdown', to: 'pages#countdown', as: 'countdown'
  
  resources :scents, only: []

  resources :smell_programs, only: [:index] do
    resources :smell_entries, only: [:new, :create, :start]
  end

  resources :smell_entries, only: []

  ##### TEST PAGE ###
  get '/test', to: 'pages#test', as: 'test'

end

