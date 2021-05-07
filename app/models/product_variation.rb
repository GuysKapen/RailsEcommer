# frozen_string_literal: true
class ProductVariation < ApplicationRecord
  # has_one :product_variation_metum
  has_one :product_meta, as: :product
  has_one :product_cart, as: :product, required: false
  belongs_to :product
  has_and_belongs_to_many :product_attributes_values

  accepts_nested_attributes_for :product_meta
  accepts_nested_attributes_for :product_attributes_values
end
