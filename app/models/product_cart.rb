class ProductCart < ApplicationRecord
  belongs_to :product, foreign_key: 'product_id', polymorphic: true
  belongs_to :product_cart_container, polymorphic: true

  delegate :name, to: :product
  delegate :price, to: :product

  def total
    product.price * quantity
  end
end
