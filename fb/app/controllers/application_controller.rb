# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[user_name avatar])
  end

  def requests
    current_user.inverse_friendships.map { |friendship| friendship unless friendship.confirmed }.compact
  end

  def timeline_posts
    friends_posts = []
    current_user.friends.each { |friend| friends_posts = friends_posts + friend.created_posts}
    friends_posts + current_user.created_posts
  end
end
