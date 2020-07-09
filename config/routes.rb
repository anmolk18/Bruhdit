Rails.application.routes.draw do
  resources :likes
  post '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/home', to: 'home#display'
  get '/analytics', to: 'home#analytics'
  root :to => 'sessions#welcome'
  
  resources :comments, only: [:new, :create, :edit, :update, :destroy]
  
  resources :tags, only: [:index, :show]

  resources :comments do 
    resources :comment_likes 
  end 

  resources :posts do
    resources :likes, only: [:create, :show, :destroy, :create]
  end

  resources :posts
  
  resources :users

  resources :conversations do
    resources :messages
   end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
