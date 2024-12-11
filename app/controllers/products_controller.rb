class ProductsController < ApplicationController
  def index
    @products = Product.includes(:brand, :category).order("title DESC")
  end

  def show
    @product = Product.find(params[:id])
  end
end
