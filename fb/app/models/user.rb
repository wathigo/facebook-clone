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
    confirmed_friends + confirmed_inverse_friends
  end

  def mutual_friends(friend)
    friends_v1 = friendships.map {|friendship| friendship.friend if self.friends.include?friendship.friend}.compact
    friends_v2 = inverse_friendships.map {|friendship| friendship.user if self.friends.include?friendship.user}.compact
    (friends_v1 + friends_v2) - [friend]
  end

  def pending_friends
    friendships.map {|friendship| friendship.friend unless friendship.confirmed}.compact
  end

  def friend_requests
    inverse_friendships.map {|friendship| friendship.user unless friendship.confirmed}.compact
  end

  def confirm_friend(requester)
    friendship = inverse_friendships.find {|friendship| friendship.user == requester}
    friendship.confirmed = true
    friendship.save
  end

  def friends?(user)
    friends.include?(user)
  end

  def recommended_friends
    friends = User.all.map {|user| user if (!self.friends? user) && (self.mutual_friends(user).size > 1) && user != self}.compact
    if friends.size < 10
      ((friends + unknown_users(self)) - [self]) - inverse_pending_friends
    else
      (friends - [self]) - inverse_pending_friends
    end
  end

  private

  def unknown_users(current_user)
    User.all.map {|user| user if (!current_user.friends.include? user) && (current_user.mutual_friends(user).size < 1)}.compact
  end

  def downcase_email
    email.downcase!
  end

  def confirmed_friends
    friendships.map {|friendship| friendship.friend if friendship.confirmed}.compact
  end

  def confirmed_inverse_friends
    inverse_friendships.map {|friendship| friendship.user if friendship.confirmed}.compact
  end

  def inverse_pending_friends
    inverse_friendships.map {|friendship| friendship.user unless friendship.confirmed}.compact
  end
end
