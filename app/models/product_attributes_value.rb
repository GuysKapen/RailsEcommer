class ProductAttributesValue < ApplicationRecord
  belongs_to :product_attributes_name
  has_and_belongs_to_many :product_variations
end
