class SearchController < ApplicationController
  def index
    @query = params[:q]

    if @query.present?
      @products = Product.includes(:brand, :category).where("title LIKE ?", "%#{@query}%")
    else
      @products = []
    end

    @products = Kaminari.paginate_array(@products).page(params[:page]).per(10)
  end
end
