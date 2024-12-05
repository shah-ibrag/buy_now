class CartController < ApplicationController
  before_action :initialize_cart

  def show
  end

  def add
    product = Product.find(params[:product_id])
    @cart << product.id
    session[:cart] = @cart
    redirect_to cart_path, notice: "#{product.name} has been added to your cart."
  end

  def remove
    product = Product.find(params[:product_id])
    @cart.delete(product.id)
    session[:cart] = @cart
    redirect_to cart_path, notice: "#{product.name} has been removed from your cart."
  end

  private

  def initialize_cart
    @cart = session[:cart] || []
  end
end