class CartController < ApplicationController
  before_action :initialize_cart

  def show
  end

  def add
    product = Product.find(params[:product_id])
    item = @cart.find { |i| i["product_id"] == product.id }
    if item
      item["quantity"] += 1
    else
      @cart << { "product_id" => product.id, "quantity" => 1 }
    end
    session[:cart] = @cart
    redirect_to cart_path, notice: "#{product.name} has been added to your cart."
  end

  def remove
    product = Product.find(params[:product_id])
    @cart.reject! { |item| item["product_id"] == product.id }
    session[:cart] = @cart
    redirect_to cart_path, notice: "#{product.name} has been removed from your cart."
  end

  def update_quantity
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    if quantity > 0
      @cart.each do |item|
        if item["product_id"] == product.id
          item["quantity"] = quantity
          break
        end
      end
      session[:cart] = @cart
      redirect_to cart_path, notice: "#{product.name} quantity has been updated."
    else
      redirect_to cart_path, alert: "Quantity must be greater than zero."
    end
  end

  private

  def initialize_cart
    @cart = session[:cart] || []
  end
end