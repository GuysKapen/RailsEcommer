class Order < ApplicationRecord
  has_many :product_carts
end
