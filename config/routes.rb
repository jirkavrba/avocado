Rails.application.routes.draw do
  root to: 'home#index'

  get '/dashboard', to: 'home#dashboard'

  # Authentication routes
  get '/sign_in', to: 'session#new'
  post '/sign_in', to: 'session#create'
  delete '/sign_out', to: 'session#destroy'

  get '/sign_up', to: 'user#new'
  post '/sign_up', to: 'user#create'

  # Collections
  resources :cards_collections do
  end
end
