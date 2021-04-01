class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.references :user_id, null: false, foreign_key: { to_table: 'users' }
      t.timestamps
    end
  end
end
