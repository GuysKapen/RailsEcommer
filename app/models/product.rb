# frozen_string_literal: true
class Product < ApplicationRecord
  # mount_uploaders :images, ImageUploader
  # serialize :images, JSON
  # serialize :up_sale, Array
  # serialize :cross_sale, Array

  belongs_to :user, dependent: :destroy
  belongs_to :category, required: false
  has_many :product_variations
  has_one :product_meta
  has_one :product_shipping, through: :product_meta
  has_one :product_inventory, through: :product_meta

  accepts_nested_attributes_for :product_meta
  accepts_nested_attributes_for :product_variations
  accepts_nested_attributes_for :product_shipping
  accepts_nested_attributes_for :product_inventory
end
