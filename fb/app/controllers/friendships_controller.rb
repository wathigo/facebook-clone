# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find_by_id(params[:id])
    if current_user.friends? friend
      redirect_back(fallback_location: root_path)
    else
      @friendship = current_user.friendships.build(friend_id: params[:id])
      @friendship.save
      redirect_back(fallback_location: root_path)
      end
  end

  def update
    user = User.find_by_id(params[:id])
    if current_user.confirm_friend(user)
      if requests.any?
        redirect_back(fallback_location: root_path)
      else
        redirect_to root_path
      end
    end
  end

  def destroy
    if params[:id]
      user = User.find_by_id(params[:id])
    else
      @friendship = current_user.inverse_pending_friendships.find_by_id(params[:friendship_id])
    end
    @friendship ||= user.inverse_pending_friendships.find { |friendship| friendship.user = current_user }
    redirect_back(fallback_location: root_path) if @friendship.delete
  end

  def show
    @friendships = current_user.inverse_friendships.map { |friendship| friendship unless friendship.confirmed }
  end
end
