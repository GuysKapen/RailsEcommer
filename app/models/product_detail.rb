class ProductDetail < ApplicationRecord
  belongs_to :product_meta

  # Validation
  validates :name, presence: true, allow_blank: false
  validates :regular_price, presence: true
end
