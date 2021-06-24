# frozen_string_literal: true
class AddIndexToProductUpsells < ActiveRecord::Migration[6.0]
  def change
    add_index :product_upsells, %i[product_id product_upsell_id]
  end
end
