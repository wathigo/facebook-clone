class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user
  validates :user_id, presence: true
end
