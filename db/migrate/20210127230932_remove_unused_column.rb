class RemoveUnusedColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :price
    remove_column :product_meta, :discount
  end
end
