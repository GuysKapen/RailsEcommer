# frozen_string_literal: true
#noinspection ALL
class ProductMeta < ApplicationRecord
  mount_uploaders :images, ImageUploader
  serialize :images, JSON
  serialize :up_sale, Array
  serialize :cross_sale, Array

  # has_one :product, polymorphic: true
  belongs_to :product, polymorphic: true
  belongs_to :product_variation, required: false, foreign_key: 'product_meta_id'

  has_one :product_inventory, required: false, dependent: :destroy
  has_one :product_linked, required: false, dependent: :destroy
  has_one :product_shipping, required: false, dependent: :destroy
  has_one :product_advanced, required: false, dependent: :destroy
  has_one :product_extra, required: false, dependent: :destroy
  has_one :product_sale_price, required: false, dependent: :destroy
  has_one :product_stock, required: false, dependent: :destroy
  has_one :product_review, required: false, dependent: :destroy
  has_one :product_detail, required: false, dependent: :destroy

  accepts_nested_attributes_for :product_inventory, reject_if: :all_blank
  accepts_nested_attributes_for :product_linked, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :product_shipping, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :product_advanced, reject_if: :all_blank
  accepts_nested_attributes_for :product_extra, reject_if: :all_blank
  accepts_nested_attributes_for :product_sale_price, reject_if: :all_blank
  accepts_nested_attributes_for :product_detail

  delegate :name, :regular_price, to: :product_detail
  delegate :sale_price, to: :product_sale_price

  # Validation
  validates_associated :product_detail
  validate :images_cant_be_blank_if_dont_have_variations

  def images_cant_be_blank_if_dont_have_variations
    if product.is_a?(Product) && product.product_variations.blank? && images.blank?
      errors.add(:images, 'Images can not be blank if is simple product')
    end
  end

end
