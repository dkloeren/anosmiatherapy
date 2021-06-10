Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe-webhooks'

  devise_for :users
  mount SimpleDiscussion::Engine => "/forum"
  root to: 'pages#home'
  # root to: 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/info', to: 'pages#info', as: 'info'
  get '/smell_programs/:id/smell_entries/start', to: 'smell_entries#start', as: 'start_smell_program_smell_entries'

  resources :scents, only: []

  resources :smell_programs, only: [:show, :index, :new, :create] do
    resources :smell_entries, only: [:new, :create]
  end

  resources :smell_entries, only: []

  resources :products, only: [:index, :show]

  resources :orders, only: [:index, :show, :create] do
    resources :payments, only: :new
  end

  ##### TEST PAGE ###
  get '/test', to: 'pages#test', as: 'test'
  get '/order/sucess', to: 'orders#show'
end
