# frozen_string_literal: true
class RenameProductIdToProductLinkedId < ActiveRecord::Migration[6.0]
  def change
    remove_index :product_upsells, name: 'index_product_upsells_on_product_id_and_product_upsell_id'
    rename_column :product_upsells, :product_id, :product_linked_id
    add_index :product_upsells, %i[product_linked_id product_upsell_id], name: 'product_upsell_index'
  end
end
