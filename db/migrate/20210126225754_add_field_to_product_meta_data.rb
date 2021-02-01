class AddFieldToProductMetaData < ActiveRecord::Migration[6.0]
  def change
    add_column :product_meta_data, :regular_price, :float
    add_column :product_meta_data, :sale_price, :float
    add_column :product_meta_data, :sale_date_start, :date
    add_column :product_meta_data, :scale_date_end, :date

    add_column :product_meta_data, :sku, :string
    add_column :product_meta_data, :manage_stock, :boolean
    add_column :product_meta_data, :stock_quantity, :integer
    add_column :product_meta_data, :low_stock_threshold, :integer
    add_column :product_meta_data, :sold_individual, :boolean
    add_column :product_meta_data, :allow_back_orders, :string
    add_column :product_meta_data, :stock_status, :string
    add_column :product_meta_data, :stock_individual, :boolean

    add_column :product_meta_data, :weight, :float
    add_column :product_meta_data, :length, :float
    add_column :product_meta_data, :width, :float
    add_column :product_meta_data, :height, :float
    add_column :product_meta_data, :shipping_class, :string

    add_column :product_meta_data, :up_sale, :string
    add_column :product_meta_data, :cross_sale, :string

    add_column :product_meta_data, :tag, :string
  end
end
