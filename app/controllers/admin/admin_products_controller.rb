class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin_user!  # Ensures only authenticated admin can access

  # List all products
  def index
    @products = Product.all
  end

  # Show details of a specific product
  def show
    @product = Product.find(params[:id])
  end

  # New product form
  def new
    @product = Product.new
  end

  # Create a new product
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # Edit an existing product
  def edit
    @product = Product.find(params[:id])
  end

  # Update an existing product
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # Delete a product
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, notice: 'Product was successfully deleted.'
  end

  private

  # Strong parameters to allow specific attributes to be updated
  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :brand_id, :image)
  end
end
