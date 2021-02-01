class ProductCart < ApplicationRecord
  has_one :product, foreign_key: 'id'
end
