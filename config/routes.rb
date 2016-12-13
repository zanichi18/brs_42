Rails.application.routes.draw do
  root "home_pages#home"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/password", to: "password_changes#new"
  post "/password", to: "password_changes#create"
  resources :users
  resources :books, only: [:index, :show]
  resources :requests, only: [:index, :create, :destroy]
  namespace :admin do
    resources :categories
    resources :users, only: [:index, :destroy]
    resources :books
  end
end
