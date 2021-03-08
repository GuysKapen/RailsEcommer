class CreateProductExtras < ActiveRecord::Migration[6.0]
  def change
    create_table :product_extras do |t|
      t.text :product_video

      t.timestamps
    end
  end
end
