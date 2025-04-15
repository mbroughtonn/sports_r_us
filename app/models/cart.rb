class Cart
  def initialize(session)
    @session = session
    @session[:cart] ||= {}
  end

  def add_product(product_id)
    product_id = product_id.to_s
    @session[:cart][product_id] ||= 0
    @session[:cart][product_id] += 1
  end

  def remove_product(product_id)
    product_id = product_id.to_s
    @session[:cart].delete(product_id)
  end

  def update_product_quantity(product_id, quantity)
    product_id = product_id.to_s
    if @session[:cart].key?(product_id) && quantity > 0
      @session[:cart][product_id] = quantity
    end
  end

  def items
    Product.find(@session[:cart].keys).map do |product|
      quantity = @session[:cart][product.id.to_s]
      { product: product, quantity: quantity }
    end
  end

  def total_price
    items.sum { |item| item[:product].price * item[:quantity] }
  end

  def empty?
    @session[:cart].empty?
  end

  def clear
    @session[:cart] = {}
  end
end
