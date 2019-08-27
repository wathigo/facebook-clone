class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    redirect_to new_user_registration_path if !user_signed_in?
  	@posts = current_user.created_posts.sort_by { |home_post| home_post.created_at }.reverse if user_signed_in?
  end
end
