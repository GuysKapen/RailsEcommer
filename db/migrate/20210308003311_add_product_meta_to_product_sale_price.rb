class AddProductMetaToProductSalePrice < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_sale_prices, :product_meta, null: false, foreign_key: true
  end
end
