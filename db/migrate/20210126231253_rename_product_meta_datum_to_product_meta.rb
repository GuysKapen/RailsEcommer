class RenameProductMetaDatumToProductMeta < ActiveRecord::Migration[6.0]
  def change
    rename_table :product_meta_data, :product_metas
  end
end
