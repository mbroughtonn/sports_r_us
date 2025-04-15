class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    cart = Cart.new(session)
    cart.add_product(product.id)

    redirect_to cart_path, notice: "#{product.name} was added to your cart."
  end

  def destroy
    cart = Cart.new(session)
    cart.remove_product(params[:id])
    redirect_to cart_path, notice: "Item removed from your cart."
  end

  def update
    product = Product.find(params[:id])
    quantity = params[:quantity].to_i
    cart = Cart.new(session)
    cart.update_product_quantity(product.id, quantity)

    redirect_to cart_path, notice: "#{product.name} quantity was updated."
  end
end
