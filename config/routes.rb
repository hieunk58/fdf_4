Rails.application.routes.draw do
  resources :products, only: [ :index, :show]
  get "users/new"
  resources :users do
    resources :orders, only: [:index]
  end

  root "products#index"
  get "home" =>"static_pages#home"
  get "signup" => "users#new"
  get "signin"  => "sessions#new"
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy"

  resources :users
  resources :comments, only: [:create, :new, :show]
  resources :suggests, only: [:index, :create]
  resource :order, only: [:show, :update, :index]
  resources :order_details, only: [:show, :create, :update, :destroy]
  resources :products, only: [ :index, :show]

  namespace :admin do
    root "products#index"
    resources :products
    resources :users, only: [:index]
    resources :orders, only: [:index, :show]
    resources :categories
    resources :suggests, only: [:index, :destroy]
  end
end
