class RemoveFieldsFromProductLinkeds < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_linkeds, :upsells, :string
    remove_column :product_linkeds, :cross_sells, :string
  end
end
