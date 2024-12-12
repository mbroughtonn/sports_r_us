class HomeController < ApplicationController
  def index
    @products = Product.includes(:brand).limit(10)

    @brands = Brand.all.limit(10)
  end
end
