class ProductsController < ApplicationController

  def index
    # uses model to fetch data
    @products = Product.all.order(created_at: :desc)
    # view
    # render :index command is implicit
  end

  def show
    @product = Product.find params[:id]
  end

end
