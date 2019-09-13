module FriendshipsHelper
  def pending_friend?(user)
    current_user.pending_friends.include? user
  end
end
