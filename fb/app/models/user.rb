# frozen_string_literal: true

class User < ApplicationRecord
  has_many :created_posts, class_name: 'Post',
                           foreign_key: 'creator_id',
                           dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :avatar
  scope :all_except, ->(user) { where.not(id: user) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX }
  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
