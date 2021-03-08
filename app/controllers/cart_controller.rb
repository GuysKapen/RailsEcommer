class CartController < ApplicationController
  def index
    @cart = Cart.find_by(user_id: current_user.id)
    @order_view = OrderNewView.new(@cart, view_context)
  end

  def view_cart
    @cart_view = CartView.new(current_user)
    respond_to do |format|
      format.js { render 'cart/show_cart_popup' }
    end
  end
end
