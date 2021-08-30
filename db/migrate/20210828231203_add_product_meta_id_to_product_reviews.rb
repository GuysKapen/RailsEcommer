class AddProductMetaIdToProductReviews < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_reviews, :product_meta, null: false, foreign_key: true
  end
end
