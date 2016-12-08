Rails.application.routes.draw do
  root "home_pages#home"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/password", to: "password_changes#new"
  post "/password", to: "password_changes#create"
  resources :users
  namespace :admin do
    resources :categories
  end
end
