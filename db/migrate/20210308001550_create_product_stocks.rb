class CreateProductStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :product_stocks do |t|
      t.integer :quantity
      t.text :in_stock
      t.references :product_meta, null: false, foreign_key: true

      t.timestamps
    end
  end
end
