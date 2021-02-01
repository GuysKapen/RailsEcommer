class RenameProductMetaTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :product_metas, :product_meta
  end
end
