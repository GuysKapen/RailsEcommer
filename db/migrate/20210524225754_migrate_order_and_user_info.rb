class MigrateOrderAndUserInfo < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_user_infos, :order_id
    add_reference :orders, :order_user_info
  end
end
