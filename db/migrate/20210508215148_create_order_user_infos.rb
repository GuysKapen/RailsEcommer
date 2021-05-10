class CreateOrderUserInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :order_user_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :country
      t.string :address
      t.string :city
      t.string :zip_code
      t.string :phone
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
