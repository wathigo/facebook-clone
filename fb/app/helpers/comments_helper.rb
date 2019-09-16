# frozen_string_literal: true

module CommentsHelper
  def max1(post)
    post.comments.sort_by(&:created_at).reverse[0, 1]
  end

  def all_comments(post)
    post.comments.sort_by(&:created_at).reverse
  end
end
