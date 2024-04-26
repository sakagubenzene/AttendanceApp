Rails.application.routes.draw do
  root 'sessions#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/index_users', to: 'users#index_users'
  
  resources :users
  resources :attendances do
    get :previous_timestamp
  end
  resources :messages, only: :show
end