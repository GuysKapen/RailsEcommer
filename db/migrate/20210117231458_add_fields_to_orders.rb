class AddFieldsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :note, :string
    add_column :orders, :expiry_date, :string
    add_column :orders, :card_code, :string
  end
end
