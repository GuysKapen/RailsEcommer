class AddProductToProductVariation < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_variations, :product, null: false, foreign_key: true

  end
end
