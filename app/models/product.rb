class Product < ApplicationRecord
  mount_uploaders :images, ImageUploader
  serialize :images, JSON
  serialize :up_sale, Array
  serialize :cross_sale, Array

  belongs_to :user
  belongs_to :category
end
