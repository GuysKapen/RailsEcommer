class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :product_carts, as: :product_cart_container
end
