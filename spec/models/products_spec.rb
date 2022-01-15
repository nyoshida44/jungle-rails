require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "is valid with all attributes" do
      category = Category.create(name: "Electronics")
      product = Product.create(name: "PS5", price: 450, quantity: 12, category: category)
      expect(product.errors.full_messages).to be_empty
    end

    it "is not valid with no name" do
      category = Category.create(name: "Clothing")
      product = Product.new(price: 20, quantity: 2000, category: category)
      product.save
      expect(product.errors.full_messages).not_to be_empty
    end

    it "is not valid with no price" do
      category = Category.create(name: "Animals")
      product = Product.new(name: "Goldfish", quantity: 40, category: category)
      product.save
      expect(product.errors.full_messages).not_to be_empty
    end

    it "is not valid with no quantity" do
      category = Category.create(name: "Bathroom")
      product = Product.new(name: "Soap", price: 5, category: category)
      product.save
      expect(product.errors.full_messages).not_to be_empty
    end

    it "is not valid with no category" do
      product = Product.new(name: "Cheese", price: 12, quantity: 400)
      product.save
      expect(product.errors.full_messages).not_to be_empty
    end

  end
end
