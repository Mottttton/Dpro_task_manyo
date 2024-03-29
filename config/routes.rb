Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  namespace :admin do
    resources :users
  end
  resources :labels, except: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
