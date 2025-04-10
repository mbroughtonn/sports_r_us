class FrontendProductsController < ApplicationController
  def index
    @products = Product.includes(:brand, :category).page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end
