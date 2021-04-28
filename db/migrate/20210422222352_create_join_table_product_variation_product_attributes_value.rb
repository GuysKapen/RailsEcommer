# frozen_string_literal: true
class CreateJoinTableProductVariationProductAttributesValue < ActiveRecord::Migration[6.0]
  def change
    create_join_table :product_variations, :product_attributes_values do |t|
      t.index %i[product_variation_id product_attributes_value_id], name: 'variation_to_attrs_value'
      t.index %i[product_attributes_value_id product_variation_id], name: 'attrs_value_to_product_variation'
    end
  end
end
