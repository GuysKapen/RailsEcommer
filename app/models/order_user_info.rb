class OrderUserInfo < ApplicationRecord
  belongs_to :order
  has_one :order_card_info

  accepts_nested_attributes_for :order_card_info

  delegate :card_number, :expired_date, :card_code, to: :order_card_info
end
