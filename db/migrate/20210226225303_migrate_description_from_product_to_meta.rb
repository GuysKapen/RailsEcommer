class MigrateDescriptionFromProductToMeta < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :description
    add_column :product_meta, :description, :text
  end
end
