class AddPolymorphicToProductMetaForProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_meta, :product_id
    add_reference :product_meta, :product, polymorphic: true
  end
end
