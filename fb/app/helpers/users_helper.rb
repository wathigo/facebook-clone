# frozen_string_literal: true

module UsersHelper
  # Returns the profile image for the given user.
  def profile_img_for(user)
    image_tag gravatar_image_url(user.email)
  end
end
