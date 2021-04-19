class CreateProductAttributesValues < ActiveRecord::Migration[6.0]
  def change
    create_table :product_attributes_values do |t|
      t.references :product_attributes_name, null: false, foreign_key: true
      t.text :value

      t.timestamps
    end
  end
end
