class RemoveFieldsFromProductMeta < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_meta, :sku
    remove_column :product_meta, :manage_stock
    remove_column :product_meta, :stock_quantity
    remove_column :product_meta, :low_stock_threshold
    remove_column :product_meta, :sold_individual
    remove_column :product_meta, :allow_back_orders
    remove_column :product_meta, :stock_status
    remove_column :product_meta, :stock_individual
    remove_column :product_meta, :weight
    remove_column :product_meta, :length
    remove_column :product_meta, :width
    remove_column :product_meta, :height
    remove_column :product_meta, :shipping_class
    remove_column :product_meta, :up_sell
    remove_column :product_meta, :cross_sell
    remove_column :product_meta, :product_video
  end
end
