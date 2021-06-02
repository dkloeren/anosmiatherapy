Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/profile', to: 'pages#profile', as: 'profile'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  resources :scents, only: []

  resources :smell_programs, only: [:index] do
    resources :smell_entries, only: [:new, :create]
  end

  # resources :smell_entries, only: []
end
