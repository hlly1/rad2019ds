Rails.application.routes.draw do
  root 'static_pages#home'
  
  get  '/allcourse', to:  'courses#index'
  get '/categories/:name', to: 'categories#show', as: 'categories'
  get '/locations/:id', to: 'locations#show', as: 'locations'
  post '/send_email',   to: 'static_pages#send_email'
  get '/contact_us', to: "static_pages#contact_us"
  
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  get  '/newcourse',  to: 'courses#new'
  post '/newcourse',  to: 'courses#create'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  get  '/addlocation',  to: 'locations#new'
  post '/addlocation',  to: 'locations#create'
  get  '/addcategory',  to: 'categories#new'
  post '/addcategory',  to: 'categories#create'
  resources :users, :categories, :locations
  resources :courses do
  	member do
      post :votelike, :votedislike, :current_votes_delete
    end
  end
  get '/users/edit', to: 'users#edit' 

end
