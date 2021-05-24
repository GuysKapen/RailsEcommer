class Cart < ApplicationRecord
  belongs_to :user
  has_many :product_carts, as: :product_cart_container

  def total
    ret = 0
    product_carts.each do |item|
      ret += (item.product.price || 0) * item.quantity
    end
    ret
  end

  def subtotal
    ret = 0
    product_carts.each do |item|
      ret += (item.product.price || 0) * item.quantity
    end
    ret
  end
end
