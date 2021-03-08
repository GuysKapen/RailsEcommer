class ProductMeta < ApplicationRecord
  mount_uploaders :images, ImageUploader
  serialize :images, JSON
  serialize :up_sale, Array
  serialize :cross_sale, Array

  belongs_to :product
  belongs_to :product_variation, required: false

  has_one :product_inventory, required: false, inverse_of: nil?
  has_one :product_linked, required: false, inverse_of: nil?
  has_one :product_shipping, required: false, inverse_of: nil?
  has_one :product_advanced, required: false, inverse_of: nil?
  has_one :product_extra, required: false, inverse_of: nil?
  has_one :product_variation, required: false, inverse_of: nil?
  has_one :product_sale_price, required: false, inverse_of: nil?
  has_one :product_stock, required: false, inverse_of: nil?
  has_one :product_review, required: false, inverse_of: nil?
  # has_one :product_attribute, required: false

  accepts_nested_attributes_for :product_inventory
  accepts_nested_attributes_for :product_linked
  accepts_nested_attributes_for :product_shipping
  accepts_nested_attributes_for :product_advanced
  accepts_nested_attributes_for :product_extra
  # accepts_nested_attributes_for :product_attribute
end
