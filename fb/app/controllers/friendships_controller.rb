class FriendshipsController < ApplicationController
    before_action :authenticate_user!

  def create
    friend = User.find_by_id(params[:id])
    unless current_user.friends? friend
      @friendship = current_user.friendships.build(friend_id: params[:id])
      @friendship.save
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    user = User.find_by_id(params[:id])
    if user.confirm_friend(current_user)
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    user = User.find_by_id(params[:id])
    @friendship = user.inverse_friendships.find {|friendship| friendship.user = current_user}
    if @friendship.delete
      redirect_back(fallback_location: root_path)
    end
  end
end
