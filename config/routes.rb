Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/signup',  to: 'users#new'
  get  '/tab',  to: 'users#index'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end
