class CreateProductShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :product_shippings do |t|
      t.decimal :weight
      t.decimal :length
      t.decimal :width
      t.decimal :height
      t.text :shipping_class

      t.timestamps
    end
  end
end
