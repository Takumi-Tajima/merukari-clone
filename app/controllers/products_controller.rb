class ProductsController < ApplicationController
  def index
    @products = Product.available_for_purchase.default_order
  end

  def show
    @product = Product.available_for_purchase.find(params.expect(:id))
  end
end
