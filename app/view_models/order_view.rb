# frozen_string_literal: true
class OrderView
  attr_reader :product_carts

  def initialize(order, view_context)
    @order = order
    @context = view_context
    @product_carts = @order.product_carts
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
