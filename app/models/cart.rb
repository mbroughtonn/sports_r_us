class Cart
  def initialize(session)
    @session = session
    @cart = @session[:cart] ||= {}
  end

  def add_product(product_id)
    product_id = product_id.to_s
    @cart[product_id] ||= 0
    @cart[product_id] += 1
  end

  def remove_product(product_id)
    @cart.delete(product_id.to_s)
  end

  def update_product_quantity(product_id, quantity)
    @cart[product_id.to_s] = quantity if @cart.key?(product_id.to_s) && quantity > 0
  end

  def items
    Product.find(@cart.keys).map do |product|
      { product: product, quantity: @cart[product.id.to_s] }
    end
  end

  def total_price
    items.sum { |item| item[:product].price * item[:quantity] }
  end

  def empty?
    @cart.empty?
  end

  def clear
    @cart.clear
  end
end
