# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find_by_id(params[:id])
    @friendship = current_user.friendships.build(friend_id: params[:id])
    redirect_back(fallback_location: root_path) if @friendship.save!
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
      @friendship = current_user.pending_inverse_friendships.find_by_id(params[:friendship_id])
    end
    @friendship ||= current_user.pending_friendships.find { |friendship| friendship.friend == user }
    redirect_back(fallback_location: root_path) if @friendship.delete
  end

  def show
    @friendships = requests
    redirect_to root_path if @friendships.empty?
  end
end
