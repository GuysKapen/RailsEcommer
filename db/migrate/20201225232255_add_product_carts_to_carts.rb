class AddProductCartsToCarts < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_carts, :cart
  end
end
