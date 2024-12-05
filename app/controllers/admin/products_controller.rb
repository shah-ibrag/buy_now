module Admin
    class ProductsController < ApplicationController
      before_action :authenticate_user!
      before_action :ensure_admin!
      before_action :set_product, only: [:edit, :update, :destroy]
  
      def index
        @products = Product.all
      end
  
      def new
        @product = Product.new
      end
  
      def create
        @product = Product.new(product_params)
        if @product.save
          redirect_to admin_products_path, notice: 'Product was successfully created.'
        else
          render :new
        end
      end
  
      def edit
      end
  
      def update
        if @product.update(product_params)
          redirect_to admin_products_path, notice: 'Product was successfully updated.'
        else
          render :edit
        end
      end
  
      def destroy
        @product.destroy
        redirect_to admin_products_path, notice: 'Product was successfully deleted.'
      end
  
      private
  
      def set_product
        @product = Product.find(params[:id])
      end
  
      def product_params
        params.require(:product).permit(:name, :description, :price, :category_id, :image)
      end
  
      def ensure_admin!
        redirect_to root_path, alert: "You are not authorized to access this page." unless current_user.admin?
      end
    end
  end