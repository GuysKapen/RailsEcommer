class ProductVariation < ApplicationRecord
  has_one :product_meta
  belongs_to :product
end
