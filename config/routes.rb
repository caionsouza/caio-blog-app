Rails.application.routes.draw do
  resources :comments, except: %i[index new show]
  resources :categories
  resources :profiles
  resources :articles

  get '/confirm_email/:token', to: 'users#confirm_email'

  post '/login', to: 'sessions#create', as: 'new_user_session'
  get '/login', to: 'sessions#login', as: 'login'
  delete '/logout', to: "sessions#destroy", as: 'logout'

  delete '/user/:id', to: 'users#destroy', as: 'user_destroy'
  get '/user/:id', to: 'users#show', as: 'user'
  patch 'user/:id', to: 'users#update'
  get '/users', to: 'users#index'
  get '/user/:id/edit', to: 'users#edit', as: 'user_edit'
  post '/users', to: "users#create"
  get '/signup', to: "users#new", as: "signup"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "pages#index"
end
