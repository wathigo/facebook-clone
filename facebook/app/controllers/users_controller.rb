class UsersController < ApplicationController
  def show
    @user = User.find_by_id(params[:format])
    puts "TF!!! #{params}"
    if @user
      @pagy, @posts = pagy_array(@user.created_posts.sort_by { |home_post| home_post.created_at }.reverse) if user_signed_in?
    end
  end
end
