class AddFieldsToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :company, :string
    add_column :orders, :country, :string
    add_column :orders, :address, :string
    add_column :orders, :city, :string
    add_column :orders, :zip_code, :integer
    add_column :orders, :phone, :string
    add_column :orders, :email, :string
    add_column :orders, :card_number, :string
    add_column :orders, :total, :decimal
  end
end
