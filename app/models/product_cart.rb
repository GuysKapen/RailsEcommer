class ProductCart < ApplicationRecord
  belongs_to :product, foreign_key: 'product_id', polymorphic: true
  belongs_to :product_cart_container, polymorphic: true
end
