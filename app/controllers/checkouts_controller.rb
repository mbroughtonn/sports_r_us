class CheckoutsController < ApplicationController
  def new
    @cart = Cart.new(session)
    @customer = Customer.new
  end

  def create
    @cart = Cart.new(session)
    @customer = Customer.new(customer_params)

    if @customer.save
      session[:customer_id] = @customer.id
    else
      flash[:alert] = "There was an error with your information. Please try again."
      return render :new
    end

    subtotal = @cart.total_price
    taxes = calculate_taxes(@customer.province, subtotal)
    total = subtotal + taxes[:total_tax]

    begin
      order = Order.create!(
        customer: @customer,
        total_price: total,
        status: "pending"
      )
    rescue => e
      flash[:alert] = "There was an error creating your order. Please try again."
      Rails.logger.error "Order creation failed: #{e.message}"
      return render :new
    end

    @cart.items.each do |item|
      order.order_items.create!(
        product: item[:product],
        quantity: item[:quantity],
        price: item[:product].price
      )
    end

    @cart.clear

    Rails.logger.debug "Order created: #{order.inspect}"
    Rails.logger.debug "Session: #{session[:customer_id]}"

    redirect_to order_path(order), notice: "Order placed successfully!"
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :address, :city, :province, :postal_code)
  end

  def calculate_taxes(province, subtotal)
    gst = pst = hst = 0

    case province
    when "BC"
      gst = subtotal * 0.05
      pst = subtotal * 0.07
    when "SK"
      gst = subtotal * 0.06
      pst = subtotal * 0.05
    when "MB"
      gst = subtotal * 0.05
      pst = subtotal * 0.07
    when "ON"
      hst = subtotal * 0.13
    when "QC"
      gst = subtotal * 0.09975
      pst = subtotal * 0.05
    when "NS", "NL", "PE", "NB"
      hst = subtotal * 0.15
    else
      gst = subtotal * 0.05
    end

    {
      gst: gst,
      pst: pst,
      hst: hst,
      total_tax: gst + pst + hst
    }
  end
end
