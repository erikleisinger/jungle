require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    it "saves a new product when all fields are provided" do
      @category = Category.new(:name => 'tests', :id => 10)
      @product = @category.products.new(
        name: 'test',
        price: 1000,
        quantity: 2
      )
      @product.save
      expect(@product).to have_attributes(:name => "test", :price => 1000, :quantity => 2, :category_id => 10)
    end
    it "when no name is provided, AR throws an error" do
      @category = Category.new(:name => 'tests', :id => 10)
      @product = @category.products.new(
        name: nil,
        price: 1000,
        quantity: 2
      )
      @product.save
      # expect(@product).to have_attributes(:name => "test", :price => 1000, :quantity => 2)
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it "has a name when one is provided" do
      @category = Category.new(:name => 'tests', :id => 10)
      @product = @category.products.new(
        name: 'test',
        price: 1000,
        quantity: 2
      )
      @product.save
      expect(@product).to have_attributes(:name => "test")
    end
    it "when no price is provided, AR throws an error" do
      @category = Category.new(:name => 'tests', :id => 10)
      @product = @category.products.new(
        name: 'test',
        price: nil,
        quantity: 2
      )
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it "has a price when one is provided" do
      @category = Category.new(:name => 'tests', :id => 10)
      @product = @category.products.new(
        name: 'test',
        price: 1000,
        quantity: 2
      )
      @product.save
      expect(@product).to have_attributes(:price => 1000)
    end
    it "when no quantity is provided, AR throws an error" do
      @category = Category.new(:name => 'tests', :id => 10)
      @product = @category.products.new(
        name: 'test',
        price: 1000,
        quantity: nil
      )
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "has a quantity when one is provided" do
      @category = Category.new(:name => 'tests', :id => 10)
      @product = @category.products.new(
        name: 'test',
        price: 1000,
        quantity: 2
      )
      @product.save
      expect(@product).to have_attributes(:quantity => 2)
    end
    it "when theres no category id, AR throws an error" do
      
      @product = Product.new(
        name: 'test',
        price: 1000,
        quantity: 2
      )
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
    it "has a category_id when associated with a category when one is provided" do
      @category = Category.new(:name => 'tests', :id => 10)
      @product = @category.products.new(
        name: 'test',
        price: 1000,
        quantity: 2
      )
      @product.save
      expect(@product).to have_attributes(:category_id => 10)
    end
  end
end
