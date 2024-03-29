# frozen_string_literal: true

class ProductView
  attr_reader :product

  def initialize(product)
    @product = product
  end

  def sale_off
    return '0%' if @product.product_meta.sale_price.nil?

    format('%.1f%%', (((@product.product_meta.product_detail.regular_price - @product.product_meta.sale_price) / @product.product_meta.product_detail.regular_price) * 100))
  end


  delegate :description, :user_id, :categories, :category, :product_meta, :product_variations, :id, :regular_price_text, :price_text, to: :product
  delegate :images, :name, to: :product_meta
end
