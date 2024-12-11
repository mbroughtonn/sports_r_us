class BrandsController < ApplicationController
  def index
    @brands = Brand.includes(:products).order("name DESC")
  end

  def show
    @brand = Brand.find(params[:id])
  end
end
