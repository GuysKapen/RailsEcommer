class AddProductIdToProductCarts < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_carts, :product
  end
end
