# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @products_view = Product
                         .all
                         .map { |product| ProductView.new(product) }
    @products_view_sale = Product
                              .joins(product_meta: [:product_sale_price])
                              .where('sale_date_start < ?', 0.day.ago)
                              .map { |product| ProductView.new(product) }
    # .joins(:product_meta)
    # .joins(ProductSalePrice.where("sale_date_start < ?", 0.day.ago))
    @cart_items = ProductCart.count
  end
end
