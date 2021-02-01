class RemoveMetaFieldFromProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :sale_date_start
    remove_column :products, :scale_date_end
    remove_column :products, :stock_quantity
    remove_column :products, :allow_back_orders
    remove_column :products, :stock_status
    remove_column :products, :stock_individual
    remove_column :products, :weight
    remove_column :products, :length
    remove_column :products, :width
    remove_column :products, :height
    remove_column :products, :shipping_class
    remove_column :products, :up_sale
    remove_column :products, :cross_sale
    remove_column :products, :low_stock_threshold
    remove_column :products, :regular_price
    remove_column :products, :sale_price
    remove_column :products, :sku
    remove_column :products, :sold_individual
    remove_column :products, :tag
    remove_column :products, :manage_stock
  end
end
