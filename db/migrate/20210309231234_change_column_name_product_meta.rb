class ChangeColumnNameProductMeta < ActiveRecord::Migration[6.0]
  def change
    change_column :product_meta, :name, :string
  end
end
