class CreateProductLinkeds < ActiveRecord::Migration[6.0]
  def change
    create_table :product_linkeds do |t|
      t.text :upsells
      t.text :cross_sells

      t.timestamps
    end
  end
end
