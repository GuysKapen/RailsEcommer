# frozen_string_literal: true
class ProductInventory < ApplicationRecord
  belongs_to :product_meta
  # validate :any_present?
  # def any_present?
  #   if %w[sku stock_status manage_stock sold_individually].all? { |attr| self[attr].blank? }
  #     errors.add :base, 'Error message'
  #   end
  # end
end
