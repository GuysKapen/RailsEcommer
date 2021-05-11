# frozen_string_literal: true
class OrderNewView
  attr_reader :product_carts

  def initialize(cart, view_context)
    @cart = cart
    @context = view_context
    @product_carts = @cart.product_carts
    # @cart.product_carts.each do |item|
    #   @products.push(Product.find_by(id: item.product_id))
    # end
  end

  def total
    ret = 0
    @product_carts.each do |item|
      ret += (item.product.price || 0) * item.quantity
    end
    ret
  end

  def subtotal
    ret = 0
    @product_carts.each do |item|
      ret += (item.product.price || 0) * item.quantity
    end
    ret
  end
end
