class CreateProductMetaData < ActiveRecord::Migration[6.0]
  def change
    create_table :product_meta_data do |t|
      t.integer :quantity
      t.decimal :discount, default: '0.0', scale: 2, precision: 12
      t.date :discount_start_date
      t.date :discount_end_date
      t.references :product, null: false, foreign_key: true
      t.integer :in_stock

      t.timestamps
    end
  end
end
