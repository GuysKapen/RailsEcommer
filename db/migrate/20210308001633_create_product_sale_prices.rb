class CreateProductSalePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :product_sale_prices do |t|
      t.decimal :sale_price
      t.decimal :sale_date_start
      t.decimal :sale_date_end

      t.timestamps
    end
  end
end
