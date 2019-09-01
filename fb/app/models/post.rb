class Post < ApplicationRecord
  belongs_to :creator,       class_name: 'User'
  validates :content, presence: true
end
