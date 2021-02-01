class AddProductCartsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_carts, :orders
  end
end
