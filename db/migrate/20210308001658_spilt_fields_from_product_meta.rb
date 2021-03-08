class SpiltFieldsFromProductMeta < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_meta, :quantity
    remove_column :product_meta, :in_stock
    remove_column :product_meta, :sale_price
    remove_column :product_meta, :sale_date_start
    remove_column :product_meta, :sale_date_end
    remove_column :product_meta, :ratings
  end
end
