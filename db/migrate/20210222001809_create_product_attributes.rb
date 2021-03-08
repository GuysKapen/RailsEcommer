class CreateProductAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :product_attributes do |t|
      t.text :name
      t.text :value

      t.timestamps
    end
  end
end
