Rails.application.routes.draw do
  # Devise and ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Root
  root to: "home#index"

  # Checkout & Stripe
  resources :checkouts, only: [:new, :create] do
    collection do
      get "success", to: "checkouts#success", as: :success
      get "cancel", to: "checkouts#cancel", as: :cancel
    end
  end

  # Orders
  resources :orders, only: [:show]

  # Cart & Items
  resource :cart, only: [:show]
  resources :cart_items, only: [:create, :destroy, :update]

  # Product browsing
  resources :frontend_products, only: [:index, :show]
  resources :products, only: [:show]

  # Categories (Frontend & Admin namespace)
  resources :categories, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  namespace :admin do
    resources :categories
  end

  # Pages & Permalinks
  resources :pages, except: [:show]
  get "pages/:permalink", to: "pages#permalink", as: :pages_permalink

  # Brands
  resources :brands, only: [:index, :show]

  # Search
  get "search", to: "search#index", as: "search"

  # Health check
  get "up", to: "rails/health#show", as: :rails_health_check
end
