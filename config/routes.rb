Rails.application.routes.draw do
  resources :inventory, except: [:show]

  root 'inventory#index'

  get '/inventory/modifications', to: 'inventory#search_modifications', as: 'search_modifications'
end
