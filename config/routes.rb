Rails.application.routes.draw do
  get "orders/show"
  get "checkouts/new"
  get "cart_items/create"
  get "cart_items/destroy"
  get "carts/show"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :frontend_products, only: [:index, :show]
  resources :products, only: [:show]
  resource :cart, only: [:show]
  resources :cart_items, only: [:create, :destroy, :update]
  resources :checkouts, only: [:new, :create]
  resources :orders, only: [:show]

  root to: "home#index"

  get "search", to: "search#index", as: "search"
  resources :pages, except: [:show]
  get "pages/:permalink" => "pages#permalink", as: :pages_permalink
  resources :brands, only: [:index, :show]
  
  resources :categories, only: [:index, :show, :new, :create, :edit, :update]
  
  get "up" => "rails/health#show", as: :rails_health_check
end
