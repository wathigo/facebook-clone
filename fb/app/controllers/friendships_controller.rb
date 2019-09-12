class FriendshipsController < ApplicationController
    before_action :authenticate_user!

  def create
    unless current_user.friends
      @friendship current_user.friendships.build(friend_id: params[:id])
      @friendship.save
    end
  end
end
