class MoveRatingsToMetaData < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :ratings
    add_column :product_meta_data, :ratings, :integer
  end
end
