class CreateOrderCardInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :order_card_infos do |t|
      t.string :card_number
      t.string :expired_date
      t.string :card_code

      t.timestamps
    end
  end
end
