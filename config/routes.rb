Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :scents, only: []

  resources :smell_programs, only: [] do
    resources :smell_entries, only: []
  end

  resources :smell_entries, only: []
end
