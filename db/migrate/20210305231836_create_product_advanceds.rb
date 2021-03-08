class CreateProductAdvanceds < ActiveRecord::Migration[6.0]
  def change
    create_table :product_advanceds do |t|
      t.text :purchase_note
      t.boolean :enable_reviews

      t.timestamps
    end
  end
end
