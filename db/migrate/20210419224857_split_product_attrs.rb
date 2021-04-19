class SplitProductAttrs < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_attributes, :value, :text
    rename_table :product_attributes, :product_attributes_names
  end
end
