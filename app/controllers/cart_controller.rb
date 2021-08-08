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

  def modify_qty
    print(params)
    qty = params['qty']
    id = params['product-cart-id']
    @product_cart = ProductCart.find(id)
    @product_cart.quantity = qty
    respond_to do |format|
      if @product_cart.save
        format.js { render 'cart/response_modify_qty', locals: { success: true } }
      else
        format.js { render 'cart/response_modify_qty', locals: { success: false } }
      end
    end
  end
end
