class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV['SECRET_ADMIN_USERNAME'], password: ENV['SECRET_ADMIN_PASS']

  def show
    @products = Product.all
    @categories = Category.all
  end

end
