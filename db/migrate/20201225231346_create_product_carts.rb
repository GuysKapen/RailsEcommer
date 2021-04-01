# frozen_string_literal: true

class CreateProductCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :product_carts do |t|
      t.references :product_id
      t.string :style
      t.string :quality
      t.string :color
      t.integer :quantity
      t.string :size
      t.references :user_id, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
