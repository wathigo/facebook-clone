class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by_id(params[:format])
    if @user
      @pagy, @posts = pagy_array(@user.created_posts.sort_by { |home_post| home_post.created_at }.reverse)
    end
  end

  def index
    @users = User.all_except(current_user)
  end
end
