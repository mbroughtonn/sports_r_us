Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :frontend_products, only: [:index, :show]

  root to: "home#index"

  get "search", to: "search#index", as: "search"
  resources :pages, except: [:show]
  get "pages/:permalink" => "pages#permalink", as: :pages_permalink
  resources :brands, only: [:index, :show]
  resources :categories, only: [:index, :show]
  get "up" => "rails/health#show", as: :rails_health_check
end
