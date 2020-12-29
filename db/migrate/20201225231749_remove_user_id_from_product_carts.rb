class RemoveUserIdFromProductCarts < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_carts, :user_id
  end
end
