Rails.application.routes.draw do

  # Authentication, Authorization
  devise_for :users

  # Forum
  mount SimpleDiscussion::Engine => "/forum"

  # Pages
  root to: 'pages#home'
  get '/info', to: 'pages#info', as: 'info'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'

  # Training
  resources :smell_programs, only: [:show, :index, :new, :create] do
    resources :smell_entries, only: [:new, :create] do
      collection do
        get :countdown
      end
    end
  end

  # Shop
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  resources :products, only: [:index, :show]
  resources :orders, only: [:index, :create] do
    resources :payments, only: :new
    member do
      get :success
    end
  end
end
