class Post < ApplicationRecord
  belongs_to :creator,       class_name: 'User'
  validates :title, presence: true
  validates :content, presence: true
end
