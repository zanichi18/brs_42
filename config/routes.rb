Rails.application.routes.draw do
  root "home_pages#home"
  resources :users
  get "/signup", to: "users#new"
  namespace :admin do
    resources :categories
    resources :users, only: [:index, :destroy]
  end
end
