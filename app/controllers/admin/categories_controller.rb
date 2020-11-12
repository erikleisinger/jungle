class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV['SECRET_ADMIN_USERNAME'], password: ENV['SECRET_ADMIN_PASS']
  layout 'application'
  def index 
    @categories = Category.all
  end
end
