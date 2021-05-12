class Order < ApplicationRecord
  has_many :product_carts, as: :product_cart_container
  belongs_to :user
  has_one :order_user_info

  accepts_nested_attributes_for :order_user_info

  delegate :first_name, :last_name, :company, :country, :address, :city, :zip_code, :phone, to: :order_user_info
  delegate :card_number, :expired_date, :card_code, to: :order_user_info
  delegate :email, to: :user
end
