class SearchController < ApplicationController
  def index
    @query = params[:q]
    @category_id = params[:category_id]

    if @query.present?
      products = Product.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{@query.downcase}%", "%#{@query.downcase}%")

      if @category_id.present? && @category_id != ""
        products = products.where(category_id: @category_id)
      end

      @products = products.includes(:category)
    else
      @products = []
    end

    @categories = Category.all
  end
end
