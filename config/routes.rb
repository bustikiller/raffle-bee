Rails.application.routes.draw do
  devise_for :users

  resources :raffles do
    get 'sell', to: 'raffles#new_sale'
    post 'sell', to: 'raffles#create_sale'
    get 'search', to: 'raffles#search'
    resources :assignments, only: [:index, :new, :create]
  end

  root to: 'home#dashboard'
end
