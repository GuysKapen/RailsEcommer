class OrderNewView
  attr_reader :products

  def initialize(cart, view_context)
    @cart = cart
    @context = view_context
    @products = []
    @cart.product_carts.each do |item|
      @products.push(Product.find_by(id: item.product_id))
    end
  end

  def total
    ret = 0
    @products.each do |item|
      ret += item.product_meta.regular_price || 0
    end
    ret
  end

  def subtotal
    ret = 0
    @products.each do |item|
      ret += item.product_meta.regular_price || 0
    end
    ret
  end
end
