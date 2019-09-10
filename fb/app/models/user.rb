# frozen_string_literal: true

class User < ApplicationRecord
  has_many :created_posts, class_name: 'Post',
                           foreign_key: 'creator_id',
                           dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :avatar
  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship",
                                 :foreign_key => "friend_id",
                                 :dependent => :destroy
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

  def friends
    confirmed_friends + inverse_friends
  end

  def pending_friends
    friendships.map {|friendship| friendship.friend unless friendship.confirmed}.compact
  end

  def friend_requests
    inverse_friendships.map {|friendship| friendship.user unless friendship.confirmed}.compact
  end

  def confirmed_friend
    friendship = inverse_friendships.map {|friendship| friendship unless friendship.user != user}.compact
    friendship.confirmed = true
  end

  def friends?
    friends.include?(user)
  end

  private

  def downcase_email
    email.downcase!
  end

  def confirmed_friends
    friendships.map {|friendship| friendship.friend if friendship.confirmed && friendship.user == user}.compact
  end

  def inverse_friends
    friendships.map {|friendship| friendship.friend if friendship.confirmed && friendship.friend == user}.compact
  end
end
