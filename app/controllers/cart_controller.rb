class CartController < ApplicationController
  def index
    @cart = Cart.find_by(user_id: current_user.id)
    @order_view = OrderNewView.new(@cart, view_context)
  end
end
