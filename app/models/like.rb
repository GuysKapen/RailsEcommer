class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id', polymorphic: true
  belongs_to :record, polymorphic: true
end
