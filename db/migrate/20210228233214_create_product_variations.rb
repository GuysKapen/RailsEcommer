class CreateProductVariations < ActiveRecord::Migration[6.0]
  def change
    create_table :product_variations do |t|

      t.timestamps
    end
  end
end
