class CartView
  attr_reader :cart, :product_carts

  def initialize(current_user)
    @cart = Cart.find_by(user_id: current_user.id)
    @product_carts = ProductCart.where(cart_id: @cart.id)
  end
  
  def cart_items
    @product_carts.length
  end

  def total
    ret = 0
    @product_carts.each do |item|
      ret += item.product.product_meta.regular_price || 0
    end
    ret
  end

  def subtotal
    ret = 0
    @product_carts.each do |item|
      ret += item.product.product_meta.regular_price || 0
    end
    ret
  end

end
