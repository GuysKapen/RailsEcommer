# frozen_string_literal: true

# noinspection ALL
class ProductSalePrice < ApplicationRecord
  attr_accessor :sale_date_start_time, :sale_date_end_time

  belongs_to :product_meta
  has_one :product_detail, through: :product_meta

  # Validation
  validate :date_end_cannot_less_than_date_start, :must_provide_date_end_if_have_date_start,
           :sale_price_must_less_than_regular_price

  def date_end_cannot_less_than_date_start
    if sale_date_end.present? && sale_date_end < sale_date_start
      errors.add(:sale_date_end, 'Sale date end cannot less than sale date start')
    end
  end

  def must_provide_date_end_if_have_date_start
    if sale_date_start.present? && !sale_date_end.present?
      errors.add(:sale_date_end, 'Sale date end must be provided if have sale date start')
    end
  end

  def sale_price_must_less_than_regular_price
    errors.add(:sale_price, 'Sale price must less than regular price') if sale_price > product_detail.regular_price
  end
end
