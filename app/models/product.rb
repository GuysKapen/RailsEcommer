# frozen_string_literal: true

class Product < ApplicationRecord
  # mount_uploaders :images, ImageUploader
  # serialize :images, JSON
  # serialize :up_sale, Array
  # serialize :cross_sale, Array

  belongs_to :user, dependent: :destroy
  belongs_to :category, required: false
  has_many :product_variations
  has_one :product_meta, as: :product, required: false
  has_one :product_cart, as: :product, required: false

  # has_one :product_shipping, through: :product_meta, required: false
  # has_one :product_inventory, through: :product_meta, required: false
  # has_one :product_sale_price, through: :product_meta, required: false

  accepts_nested_attributes_for :product_meta
  accepts_nested_attributes_for :product_variations

  def price_text
    if product_variations.blank?
      format('%s', ActionController::Base.helpers.number_to_currency(product_meta.product_detail.regular_price))
    else
      prices = product_variations.map { |it| it.product_meta.product_detail.regular_price }
      format('%<low>s - %<high>s',
             {low: ActionController::Base.helpers.number_to_currency(prices.min),
              high: ActionController::Base.helpers.number_to_currency(prices.max)})
    end
  end

  def sale_price_text
    prices = product_variations.filter_map do |it|
      it.product_meta.product_sale_price&.sale_price unless it.product_meta.product_sale_price.nil?
    end.to_set
    if prices.blank?
      format('%s', ActionController::Base.helpers.number_to_currency(product_meta.product_sale_price.sale_price))
    elsif prices.size == 1
      format('%s', ActionController::Base.helpers.number_to_currency(prices.first))
    else
      format('%<low>s - %<high>s',
             {low: ActionController::Base.helpers.number_to_currency(prices.min),
              high: ActionController::Base.helpers.number_to_currency(prices.max)})
    end
  end

  def price
    product_meta.product_sale_price&.sale_price || product_meta.product_detail.regular_price
  end

  delegate :name, :regular_price, to: :product_meta
end
