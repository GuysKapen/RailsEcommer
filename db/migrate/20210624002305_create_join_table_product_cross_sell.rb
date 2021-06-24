class CreateJoinTableProductCrossSell < ActiveRecord::Migration[6.0]
  def change
    create_table 'product_cross_sells', force: true, id: false do |t|
      t.integer 'product_linked_id', null: false
      t.integer 'product_cross_sell_id', null: false
      t.index %i[product_linked_id product_cross_sell_id], name: 'product_cross_sell_index'
    end
  end
end
