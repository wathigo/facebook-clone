module FriendshipsHelper
  def pending_friend?(user)
    current_user.pending_friends.include? user
  end

  def friend_request
    current_user.inverse_friendships.map {|friendship| friendship unless friendship.confirmed}.compact
  end
end
