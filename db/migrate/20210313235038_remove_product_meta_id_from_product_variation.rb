class RemoveProductMetaIdFromProductVariation < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_variations , :product_meta_id
  end
end
