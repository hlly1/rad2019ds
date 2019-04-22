Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/signup',  to: 'users#new'
  get  '/tab',  to: 'users#index'
  resources :users
end
