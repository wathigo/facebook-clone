# frozen_string_literal: true

class AddCreatorToPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :user_id, :integer
    add_column :posts, :creator_id, :integer
    add_index :posts, %i[creator_id created_at]
  end
end
