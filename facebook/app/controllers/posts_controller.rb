class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = current_user.created_posts.build
  end

  def create
    @post = current_user.created_posts.build(post_params)
    if @post.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
    @pagy, @posts = pagy_array(Post.all.sort_by { |home_post| home_post.created_at }.reverse) if user_signed_in?
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
