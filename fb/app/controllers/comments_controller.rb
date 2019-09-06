class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:format])
    puts params
    if @comment.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
