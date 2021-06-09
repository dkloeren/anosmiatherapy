class ProductsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @products = Product.all.sort_by(&:order)
  end

  def show
    @product = Product.find(params[:id])
  end
end
