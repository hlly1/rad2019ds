Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/signup',  to: 'users#new'
  get  '/tab',  to: 'users#index'
  post '/signup',  to: 'users#create'
  resources :users
end
