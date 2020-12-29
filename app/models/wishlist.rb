class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :product_carts
end
