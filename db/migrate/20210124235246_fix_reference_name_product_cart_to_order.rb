class FixReferenceNameProductCartToOrder < ActiveRecord::Migration[6.0]
  def change
    remove_reference :product_carts, :orders
    add_reference :product_carts, :order
  end
end
