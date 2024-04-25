Rails.application.routes.draw do
  root 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users
  resources :attendances do
    get :previous_timestamp
  end
  resources :messages, only: :show
end