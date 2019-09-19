class RemoveIndexFromFriend < ActiveRecord::Migration[5.2]
  def change
    remove_index :friendships, column: :friend_id
    remove_index :friendships, column: :user_id
  end
end
