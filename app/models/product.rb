class Product < ApplicationRecord
  mount_uploaders :images, ImageUploader
  serialize :images, JSON
  serialize :up_sale, Array
  serialize :cross_sale, Array

  belongs_to :user, dependent: :destroy
  belongs_to :category, required: false
  has_one :product_meta

  accepts_nested_attributes_for :product_meta
end
