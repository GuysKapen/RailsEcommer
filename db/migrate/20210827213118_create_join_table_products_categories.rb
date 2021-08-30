class CreateJoinTableProductsCategories < ActiveRecord::Migration[6.0]
  def change
    create_join_table :products, :categories do |t|
      t.index %i[product_id category_id], name: 'product_to_category_index'
      t.index %i[category_id product_id], name: 'category_to_product_index'
    end
  end
end
