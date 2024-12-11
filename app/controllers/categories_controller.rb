class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:products).order("name DESC")
  end

  def show
    @category = Category.find(params[:id])
  end
end
