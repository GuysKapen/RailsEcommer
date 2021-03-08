class AddProductMetaToProductAdvanced < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_advanceds, :product_meta, null: false, foreign_key: true
  end
end
