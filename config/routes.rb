Rails.application.routes.draw do
  resources :products, only: [ :index, :show]

  get "users/new"
  resources :users

  root "static_pages#home"
  get "home" =>"static_pages#home"
  get "signup" => "users#new"
  get "signin"  => "sessions#new"
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy"
  resources :comments, only: [:create, :new, :show]
  resources :suggests, only: [:index, :create]

  namespace :admin do
    resources :products
    resources :users, except: [:new, :create, :destroy]
    resources :orders, only: [:index, :show]
    resources :suggests, only: [:index, :destroy]
    resources :categories , only: [:index, :new, :create, :destroy]
  end
end
