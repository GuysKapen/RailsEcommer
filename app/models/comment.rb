class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :replies
  has_many :likes, as: :record
end
