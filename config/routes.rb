Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/profile', to: 'pages#profile', as: 'profile'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/info', to: 'pages#info', as: 'info'
  get '/countdown', to: 'pages#countdown', as: 'countdown'
  get '/smell_programs/:id/smell_entries/start', to: 'smell_entries#start', as: 'start_smell_program_smell_entries'

  resources :scents, only: []

  resources :smell_programs, only: [:index] do
    resources :smell_entries, only: [:new, :create]
  end

  resources :smell_entries, only: [:show, :index]

  ##### TEST PAGE ###
  get '/test', to: 'pages#test', as: 'test'
end

