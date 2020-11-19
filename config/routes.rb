Rails.application.routes.draw do
  root to: 'home#index'

  get '/dashboard', to: 'home#dashboard'

  # Authentication routes
  get '/sign_in', to: 'session#new'
  post '/sign_in', to: 'session#create'
end
