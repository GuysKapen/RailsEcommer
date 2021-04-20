# frozen_string_literal: true
class ProductAttributesName < ApplicationRecord
  has_many :product_attributes_values

  def value
    product_attributes_values.map(&:value).join('|')
  end

  def [](key)
    if key.to_s == 'value'
      value
    else
      super
    end
  end
end
