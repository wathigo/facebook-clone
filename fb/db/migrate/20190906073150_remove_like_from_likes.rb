# frozen_string_literal: true

class RemoveLikeFromLikes < ActiveRecord::Migration[5.2]
  def change
    remove_column :likes, :like, :integer
  end
end
