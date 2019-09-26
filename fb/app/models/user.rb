# frozen_string_literal: true

class User < ApplicationRecord
  has_many :created_posts, class_name: 'Post',
                           foreign_key: 'creator_id',
                           dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :avatar
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship',
                                 foreign_key: 'friend_id',
                                 dependent: :destroy
  has_many :confirmed_friendships, -> { where(confirmed: true) }, class_name: 'Friendship', foreign_key: :user_id, dependent: :destroy
  has_many :confirmed_inverse_friendships, -> { where(confirmed: true) }, class_name: 'Friendship', foreign_key: :friend_id, dependent: :destroy
  has_many :pending_friendships, -> { where(confirmed: false) }, class_name: 'Friendship', foreign_key: :user_id, dependent: :destroy
  has_many :pending_inverse_friendships, -> { where(confirmed: false) }, class_name: 'Friendship', foreign_key: :friend_id, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX }

  def friends
    confirmed_friends + confirmed_inverse_friends
  end

  def mutual_friends(user)
    friends_v1 = confirmed_friends & user.confirmed_friends
    friends_v2 = confirmed_inverse_friends & user.confirmed_inverse_friends
    (friends_v1 + friends_v2) - [user]
  end

  def confirm_friend(requester)
    friendship = inverse_friendships.find { |friendship| friendship.user == requester }
    friendship.confirmed = true
    friendship.save!
  end

  def friends?(user)
    friends.include?(user)
  end

  def recommended_friends
    friends = User.all.map { |user| user if (!self.friends? user) && (mutual_friends(user).size > 1) }.compact
    if friends.size < 10
      ((friends + unknown_users(self)) - [self]) - pending_requests
    else
      (friends - [self]) - pending_requests
    end
  end

  def confirmed_friends
    confirmed_friendships.map { |friendship| friendship.friend }
  end

  def confirmed_inverse_friends
    confirmed_inverse_friendships.map { |friendship| friendship.user }
  end

  def pending_requests
    pending_inverse_friendships.map { |friendship| friendship.user}
  end

  private

  def unknown_users(current_user)
    User.all.map { |user| user if (!current_user.friends? user) }.compact
  end

end
