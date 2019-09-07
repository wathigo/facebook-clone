# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :likes, as: :likeable
  has_many :comments, dependent: :destroy
  validates :content, presence: true
end
