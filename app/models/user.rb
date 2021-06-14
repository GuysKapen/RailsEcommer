class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :categories
  has_one :cart
  has_one :wishlist
  has_many :orders
  has_many :comments
  has_many :replies
  has_many :likes, as: :user

  def like_record?(record)
    Like.exists?(user_id: id, record_id: record.id, record_type: record.class.to_s)
  end

end
