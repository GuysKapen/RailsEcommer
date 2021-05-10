# frozen_string_literal: true
class ProductMeta < ApplicationRecord
  mount_uploaders :images, ImageUploader
  serialize :images, JSON
  serialize :up_sale, Array
  serialize :cross_sale, Array

  # has_one :product, polymorphic: true
  belongs_to :product, polymorphic: true
  has_one :product_variation, required: false, foreign_key: 'product_meta_id'

  has_one :product_inventory, required: false
  has_one :product_linked, required: false
  has_one :product_shipping, required: false
  has_one :product_advanced, required: false
  has_one :product_extra, required: false
  has_one :product_variation, required: false
  has_one :product_sale_price, required: false
  has_one :product_stock, required: false
  has_one :product_review, required: false
  has_one :product_detail, required: false
  # has_one :product_attribute, required: false

  accepts_nested_attributes_for :product_inventory, reject_if: :all_blank
  accepts_nested_attributes_for :product_linked, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :product_shipping, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :product_advanced, reject_if: :all_blank
  accepts_nested_attributes_for :product_extra, reject_if: :all_blank
  accepts_nested_attributes_for :product_sale_price, reject_if: :all_blank
  accepts_nested_attributes_for :product_detail, reject_if: :all_blank
  # accepts_nested_attributes_for :product_attribute
end
