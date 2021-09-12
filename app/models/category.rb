# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :user
  has_many :products

  validates :name, presence: true, allow_blank: false,
                   uniqueness: { scope: :user_id, message: 'Category already exist' }
end
