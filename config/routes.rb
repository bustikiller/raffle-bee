Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount Riews::Engine, at: '/riews'

  resources :raffles do
    get 'sell', to: 'raffles#new_sale'
    post 'sell', to: 'raffles#create_sale'

    resources :tickets, only: :index
  end

  root to: 'home#dashboard'
end
