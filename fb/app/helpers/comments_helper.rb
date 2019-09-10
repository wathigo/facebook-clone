# frozen_string_literal: true

module CommentsHelper
  def max4(post)
    post.comments.sort_by { |comment| comment.created_at }.reverse[0, 3]
  end
end
