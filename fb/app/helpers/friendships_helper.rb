# frozen_string_literal: true

module FriendshipsHelper
  def pending_friend?(user)
    current_user.pending_friends.include? user
  end

  def request?(user)
    current_user.pending_requests.include? user
  end

  def friend_request
    current_user.pending_inverse_friendships
  end

  def mutual_friends(user)
    current_user.mutual_friends(user)
  end
  def pending_inverse_friend?(user)
    current_user.pending_inverse_friends.include? user
  end
end
