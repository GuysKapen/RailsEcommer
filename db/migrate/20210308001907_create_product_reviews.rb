class CreateProductReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :product_reviews do |t|
      t.integer :ratings

      t.timestamps
    end
  end
end
