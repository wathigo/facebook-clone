class FriendshipsController < ApplicationController
    before_action :authenticate_user!

  def create
    friend = User.find_by_id(params[:id])
    unless current_user.friends? friend
      @friendship current_user.friendships.build(friend_id: params[:id])
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
    @friendship = user.friendships.find {|friendship| friendship.friend = current_user}
    if @friendship.destroy
      redirect_back(fallback_location: root_path)
    end
  end 
end
