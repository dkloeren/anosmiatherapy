Rails.application.routes.draw do
  devise_for :users
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  mount SimpleDiscussion::Engine => "/forum"

  #
  root to: 'pages#home'
  get '/info', to: 'pages#info', as: 'info'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'


  resources :smell_programs, only: [:show, :index, :new, :create] do
    resources :smell_entries, only: [:new, :create] do
      collection do
        # countdown
        get :start
      end
    end
  end

  resources :products, only: [:index, :show]

  resources :orders, only: [:index, :create] do
    resources :payments, only: :new
    member do
      get :success
    end
  end
end
