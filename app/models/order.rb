class Order < ApplicationRecord
  has_one :cart
  belongs_to :user
  has_one :order_user_info

  accepts_nested_attributes_for :order_user_info
end
