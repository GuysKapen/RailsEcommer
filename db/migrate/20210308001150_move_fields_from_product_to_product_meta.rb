class MoveFieldsFromProductToProductMeta < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :images
    remove_column :products, :name

    add_column :product_meta, :images, :text
    add_column :product_meta, :name, :text
  end
end
