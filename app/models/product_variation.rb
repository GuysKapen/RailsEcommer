# frozen_string_literal: true

# Product variation that has many style for options
class ProductVariation < ApplicationRecord
  has_one :product_meta, as: :product, dependent: :destroy
  has_many :product_carts, as: :product
  belongs_to :product
  has_and_belongs_to_many :product_attributes_values

  accepts_nested_attributes_for :product_meta
  accepts_nested_attributes_for :product_attributes_values

  def price_text
    if sale_price_text.blank?
      regular_price_text
    else
      sale_price_text
    end
  end

  def regular_price_text
    format('%s', ActionController::Base.helpers.number_to_currency(product_meta.product_detail.regular_price))
  end

  def price_and_sale_price_text
    if product_meta.product_sale_price.nil?
      price_text
    else
      format('%<regular>s - %<sale>s', {regular: price_text, sale: sale_price_text})
    end
  end

  def sale_price_text
    format('%s', ActionController::Base.helpers.number_to_currency(product_meta.product_sale_price&.sale_price))
  end

  def price
    product_meta.product_sale_price&.sale_price || product_meta.product_detail.regular_price
  end

  delegate :name, to: :product

  # Validation
  validates_associated :product_meta
end
