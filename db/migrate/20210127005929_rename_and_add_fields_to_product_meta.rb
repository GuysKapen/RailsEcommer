class RenameAndAddFieldsToProductMeta < ActiveRecord::Migration[6.0]
  def change
    rename_column :product_meta, :up_sale, :up_sell
    rename_column :product_meta, :cross_sale, :cross_sell

    add_column :product_meta, :product_video, :string

  end
end
