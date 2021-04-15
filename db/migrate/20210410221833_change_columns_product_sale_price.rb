class ChangeColumnsProductSalePrice < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_sale_prices, :sale_date_start
    add_column :product_sale_prices, :sale_date_start, :datetime
    remove_column :product_sale_prices, :sale_date_end
    add_column :product_sale_prices, :sale_date_end, :datetime
  end
end
