Rails.application.routes.draw do

  mount StripeEvent::Engine, at: '/stripe-webhooks'

  devise_for :users
  # create own post system
  mount SimpleDiscussion::Engine => "/forum"
  root to: 'pages#home'

  resources :orders, only: [:show] do
    member do
      get :success, to: 'orders#show'  # not show .. but use success action
    end
  end

  namespace :dashboard do
    collection  do
      get :dashboard, to: 'pages#dashboard'
    end
  end

  namsespace :info do
    collection do
      get :info, to: 'pages#info'
    end
  end

  # get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  # get '/info', to: 'pages#info', as: 'info'

  # get '/smell_programs/:id/smell_entries/start', to: 'smell_entries#start', as: 'start_smell_program_smell_entries'

  resources :smell_programs, only: [:show, :index, :new, :create] do
    resources :smell_entries, only: [:new, :create] do
      member do
        get :start, to: 'smell_entries#start'
      end
    end
  end

  resources :products, only: [:index, :show]

  resources :orders, only: [:index, :show, :create] do
    resources :payments, only: :new
  end
end
