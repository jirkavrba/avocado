Rails.application.routes.draw do
  root to: 'home#index'
  get '/dashboard', to: 'home#dashboard'
end
