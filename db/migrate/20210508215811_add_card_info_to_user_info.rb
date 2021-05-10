class AddCardInfoToUserInfo < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_card_infos, :order_user_info, foreign_key: true
  end
end
