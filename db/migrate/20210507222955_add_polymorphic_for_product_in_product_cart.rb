class AddPolymorphicForProductInProductCart < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_carts, :product_id
    add_reference :product_carts, :product, polymorphic: true
  end
end
