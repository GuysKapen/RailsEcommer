class HomeController < ApplicationController
  def index
    @products = Product.all
    @cart_items = ProductCart.count
  end
end
