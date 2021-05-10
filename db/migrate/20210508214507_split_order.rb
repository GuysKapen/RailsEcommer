class SplitOrder < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :first_name
    remove_column :orders, :last_name
    remove_column :orders, :company
    remove_column :orders, :country
    remove_column :orders, :address
    remove_column :orders, :city
    remove_column :orders, :zip_code
    remove_column :orders, :phone
    remove_column :orders, :email
    remove_column :orders, :card_number
    remove_column :orders, :expiry_date
    remove_column :orders, :card_code
  end
end
