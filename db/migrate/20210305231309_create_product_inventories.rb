class CreateProductInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :product_inventories do |t|
      t.text :sku
      t.text :stock_status
      t.boolean :manage_stock
      t.boolean :sold_individually

      t.timestamps
    end
  end
end
