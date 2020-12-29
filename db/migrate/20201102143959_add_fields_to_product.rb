class AddFieldsToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :regular_price, :float
    add_column :products, :sale_price, :float
    add_column :products, :sale_date_start, :date
    add_column :products, :scale_date_end, :date

    add_column :products, :sku, :string
    add_column :products, :manage_stock, :boolean
    add_column :products, :stock_quantity, :integer
    add_column :products, :low_stock_threshold, :integer
    add_column :products, :sold_individual, :boolean
    add_column :products, :allow_back_orders, :string
    add_column :products, :stock_status, :string
    add_column :products, :stock_individual, :boolean

    add_column :products, :weight, :float
    add_column :products, :length, :float
    add_column :products, :width, :float
    add_column :products, :height, :float
    add_column :products, :shipping_class, :string

    add_column :products, :up_sale, :string
    add_column :products, :cross_sale, :string

    add_column :products, :tag, :string

    add_reference :products, :user, index: true

    add_reference :products, :category
  end
end
