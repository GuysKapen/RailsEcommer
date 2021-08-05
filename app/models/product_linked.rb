class ProductLinked < ApplicationRecord
  attr_accessor :product_upsell_ids_string, :product_cross_sell_ids_string, :upsells, :cross_sells

  belongs_to :product_meta
  has_and_belongs_to_many(:product_upsells, class_name: 'Product', join_table: 'product_upsells', foreign_key: 'product_linked_id',
                                            association_foreign_key: 'product_upsell_id')
  has_and_belongs_to_many(:product_cross_sells, class_name: 'Product', join_table: 'product_cross_sells', foreign_key: 'product_linked_id',
                                                association_foreign_key: 'product_cross_sell_id')

  accepts_nested_attributes_for :product_upsells
  accepts_nested_attributes_for :product_cross_sells
end
