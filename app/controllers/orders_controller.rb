class OrdersController < ApplicationController
    before_action :initialize_cart
  
    def new
      @order = Order.new
      @customer = Customer.new
    end
  
    def create
      @customer = Customer.new(customer_params)
      if @customer.save
        @order = Order.new(order_params)
        @order.customer = @customer
        @order.total_price = calculate_total_price
        if @order.save
          save_order_items
          session[:cart] = []
          redirect_to order_path(@order), notice: 'Order was successfully created.'
        else
          render :new
        end
      else
        render :new
      end
    end
  
    def show
      @order = Order.find(params[:id])
    end
  
    private
  
    def initialize_cart
      @cart = session[:cart] || []
    end
  
    def customer_params
      params.require(:customer).permit(:name, :email, :address, :city, :province, :postal_code)
    end
  
    def order_params
      params.require(:order).permit(:status)
    end
  
    def calculate_total_price
      subtotal = @cart.sum { |item| Product.find(item[:product_id]).price * item[:quantity] }
      taxes = calculate_taxes(subtotal, @customer.province)
      subtotal + taxes
    end
  
    def calculate_taxes(subtotal, province)
      tax_rates = {
        "AB" => { gst: 0.05, pst: 0.00, hst: 0.00 },
        "BC" => { gst: 0.05, pst: 0.07, hst: 0.00 },
        "MB" => { gst: 0.05, pst: 0.07, hst: 0.00 },
        "NB" => { gst: 0.00, pst: 0.00, hst: 0.15 },
        "NL" => { gst: 0.00, pst: 0.00, hst: 0.15 },
        "NS" => { gst: 0.00, pst: 0.00, hst: 0.15 },
        "ON" => { gst: 0.00, pst: 0.00, hst: 0.13 },
        "PE" => { gst: 0.00, pst: 0.00, hst: 0.15 },
        "QC" => { gst: 0.05, pst: 0.09975, hst: 0.00 },
        "SK" => { gst: 0.05, pst: 0.06, hst: 0.00 }
      }
      rates = tax_rates[province]
      gst = subtotal * rates[:gst]
      pst = subtotal * rates[:pst]
      hst = subtotal * rates[:hst]
      gst + pst + hst
    end
  
    def save_order_items
      @cart.each do |item|
        product = Product.find(item[:product_id])
        OrderItem.create!(
          order: @order,
          product: product,
          quantity: item[:quantity],
          price: product.price
        )
      end
    end
  end