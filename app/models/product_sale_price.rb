# frozen_string_literal: true
class ProductSalePrice < ApplicationRecord
  attr_accessor :sale_date_start_time, :sale_date_end_time

  belongs_to :product_meta
end
