class RemoveTypoColumnNameProductCart < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_carts, :product_id_id
  end
end
