# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @products = Product
                .all
                .map { |product| ProductView.new(product) }
    @products_view_sale = Product
                          .joins(:product_meta)
                          .where('product_meta.sale_date_start < ?', 0.day.ago)
                          .map { |product| ProductView.new(product) }
    @cart_items = ProductCart.count
  end
end
