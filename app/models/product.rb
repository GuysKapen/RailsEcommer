# frozen_string_literal: true

class Product < ApplicationRecord
  # mount_uploaders :images, ImageUploader
  # serialize :images, JSON
  # serialize :up_sale, Array
  # serialize :cross_sale, Array
  paginates_per 9

  belongs_to :user
  has_and_belongs_to_many :categories, required: false
  has_many :product_variations, dependent: :destroy
  has_many :product_carts, as: :product
  has_many :comments, dependent: :destroy
  has_one :product_linked, through: :product_meta
  has_many :product_upsells, class_name: 'Product', through: :product_linked
  has_one :product_meta, as: :product, required: false, dependent: :destroy

  accepts_nested_attributes_for :product_meta
  accepts_nested_attributes_for :product_variations
  # accepts_nested_attributes_for :product_upsells

  def regular_price_text
    if product_variations.blank?
      format('%s', ActionController::Base.helpers.number_to_currency(product_meta.product_detail.regular_price))
    else
      prices = product_variations.map { |it| it.product_meta.product_detail.regular_price }
      format('%<low>s - %<high>s',
             { low: ActionController::Base.helpers.number_to_currency(prices.min),
               high: ActionController::Base.helpers.number_to_currency(prices.max) })
    end
  end

  def sale_price_text
    prices = product_variations.filter_map do |it|
      it.product_meta.product_sale_price&.sale_price unless it.product_meta.product_sale_price.nil?
    end.to_set
    if prices.blank?
      if product_meta.product_sale_price.nil?
        ''
      else
        ActionController::Base.helpers.number_to_currency(product_meta.product_sale_price.sale_price)
      end
      # format('%s', ActionController::Base.helpers.number_to_currency(product_meta.product_sale_price.sale_price))
    elsif prices.size == 1
      format('%s', ActionController::Base.helpers.number_to_currency(prices.first))
    else
      format('%<low>s - %<high>s',
             { low: ActionController::Base.helpers.number_to_currency(prices.min),
               high: ActionController::Base.helpers.number_to_currency(prices.max) })
    end
  end

  def price_text
    if sale_price_text.blank?
      regular_price_text
    else
      sale_price_text
    end
  end

  def price
    product_meta.product_sale_price&.sale_price || product_meta.product_detail.regular_price
  end

  def price_include_variation_min
    product_meta.product_sale_price&.sale_price || product_meta.product_detail.regular_price || product_variations.filter_map do |it|
      it.product_meta.product_sale_price&.sale_price unless it.product_meta.product_sale_price.nil?
    end.to_set.min
  end

  def price_include_variation_max
    product_meta.product_sale_price&.sale_price || product_meta.product_detail.regular_price || product_variations.filter_map do |it|
      it.product_meta.product_sale_price&.sale_price unless it.product_meta.product_sale_price.nil?
    end.to_set.max
  end

  def rating
    ratings = comments.map(&:rating)
    (ratings.sum.to_f / ratings.size).truncate(1)
  end

  def category
    categories[0]
  end

  delegate :name, :regular_price, to: :product_meta
end
