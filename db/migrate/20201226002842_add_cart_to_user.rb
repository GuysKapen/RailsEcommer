class AddCartToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :carts, :user
  end
end
