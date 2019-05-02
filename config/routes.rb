Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/allcourse', to:  'static_pages#index'
  get  '/locat141031',  to:  'static_pages#locat141031'
  get  '/locat140826',  to:  'static_pages#locat140826'
  get  '/locat141030',  to:  'static_pages#locat141030'
  get  '/web',  to:  'static_pages#web'
  get  '/signup',  to: 'users#new'
  get  '/tab',  to: 'users#index'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end
