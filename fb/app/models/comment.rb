class Comment < ApplicationRecord
  has_many :likes, as: :likeable
  belongs_to :post
  belongs_to :user
  validates :content, presence: true
end
