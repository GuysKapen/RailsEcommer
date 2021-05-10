class RemoveProductDetailsFieldsInMeta < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_meta, :regular_price
    remove_column :product_meta, :description
    remove_column :product_meta, :name
  end
end
