Rails.application.routes.draw do
  resources :statuses
  root :to => 'statuses#index'
  resources :user_sessions
  resources :users

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  resources :notes
  resources :domains
  resources :watchers
end
