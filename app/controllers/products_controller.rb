class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @categories = Category.all
    @products = []

    if params[:keyword].present? || params[:category_id].present?
      @products = Product.all

      if params[:keyword].present?
        keyword = "%#{params[:keyword]}%"
        @products = @products.where("name LIKE ? OR description LIKE ?", keyword, keyword)
      end

      if params[:category_id].present?
        @products = @products.where(category_id: params[:category_id])
      end
    end
  end
end