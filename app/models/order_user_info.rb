class OrderUserInfo < ApplicationRecord
  belongs_to :order
  has_one :order_card_info

  accepts_nested_attributes_for :order_card_info
end
