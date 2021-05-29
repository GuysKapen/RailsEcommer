class UserController < ApplicationController
  def index

  end

  def show
    @orders = current_user.orders
    @products = current_user.products
    @order_user_infos = current_user.orders.map(&:order_user_info).to_set
    @wishlist = current_user.wishlist
  end
end
