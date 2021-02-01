class RemoveUnusedAndRenameColumnProductMeta < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_meta, :discount_start_date
    remove_column :product_meta, :discount_end_date
    rename_column :product_meta, :scale_date_end, :sale_date_end
  end
end
