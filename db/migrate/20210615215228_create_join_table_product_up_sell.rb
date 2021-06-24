# frozen_string_literal: true
class CreateJoinTableProductUpSell < ActiveRecord::Migration[6.0]
  def change
    create_table 'product_upsells', force: true, id: false do |t|
      t.integer 'product_id', null: false
      t.integer 'product_upsell_id', null: false
    end
  end
end
