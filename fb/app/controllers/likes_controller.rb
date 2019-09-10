# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @liked = likeable.likes.find_by(user_id: current_user.id)
    if !@liked
      likeable.likes.create(user_id: current_user.id)
      redirect_back(fallback_location: root_path)
    else
      destroy
    end
  end

  def destroy
    @liked ||= likeable.likes.find_by(user_id: current_user.id)
    if @liked.delete
      redirect_back(fallback_location: root_path)
    end 
  end

  private

  def likeable
    if params[:post_id]
      Post.find_by_id(params[:post_id])
    elsif params[:comment_id]
      Comment.find_by_id(params[:comment_id])
    end
  end
end
