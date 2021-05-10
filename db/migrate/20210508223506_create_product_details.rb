class CreateProductDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :product_details do |t|
      t.references :product_meta, null: false, foreign_key: true
      t.decimal :regular_price
      t.text :description
      t.string :name

      t.timestamps
    end
  end
end
