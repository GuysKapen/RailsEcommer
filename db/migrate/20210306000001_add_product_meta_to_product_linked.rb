class AddProductMetaToProductLinked < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_linkeds, :product_meta, null: false, foreign_key: true
  end
end
