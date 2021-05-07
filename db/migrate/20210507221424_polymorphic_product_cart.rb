class PolymorphicProductCart < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_carts, :cart_id, :integer
    remove_column :product_carts, :wishlist_id, :integer
    remove_column :product_carts, :order_id, :integer
    remove_column :product_carts, :style, :string
    remove_column :product_carts, :quality, :string
    remove_column :product_carts, :color, :string
    remove_column :product_carts, :size, :string
    add_reference :product_carts, :product_cart_container, polymorphic: true, index: false
  end
end
