# frozen_string_literal: true

class ProductView
  attr_reader :product

  def initialize(product)
    @product = product
  end

  def sale_off
    return '0%' if @product.product_meta.sale_price.nil?

    '%.0f%%' % (((@product.product_meta.regular_price - @product.product_meta.sale_price) / @product.product_meta.regular_price) * 100)
  end

  delegate :images, :name, :description, :user_id, :category, :product_meta, :id, to: :product
end
