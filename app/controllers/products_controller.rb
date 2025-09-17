class ProductsController < ApplicationController
  def index
    @products = Product.default_order
  end

  def show
    @product = Product.find(params.expect(:id))
  end
end
