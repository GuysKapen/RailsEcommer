# frozen_string_literal: true
class ProductVariation < ApplicationRecord
  # has_one :product_variation_metum
  has_one :product_meta, as: :product
  belongs_to :product

  accepts_nested_attributes_for :product_meta
end
