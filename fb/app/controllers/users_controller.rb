# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by_id(params[:format])
    @pagy, @posts = pagy_array(@user.created_posts.sort_by(&:created_at).reverse) if @user
  end

  def index
    @users = current_user.recommended_friends
  end
end
