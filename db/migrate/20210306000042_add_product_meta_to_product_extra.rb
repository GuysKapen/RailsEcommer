class AddProductMetaToProductExtra < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_extras, :product_meta, null: false, foreign_key: true
  end
end
