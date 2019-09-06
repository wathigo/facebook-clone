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
    @liked.delete
    redirect_back(fallback_location: root_path)
  end

  private

  def likeable
    if request.env['PATH_INFO'].match(/likes_post/)
      @post = Post.find_by_id(params[:format])
    else
      @comment = Comment.find_by_id(params[:format])
    end
  end
end
