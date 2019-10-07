# frozen_string_literal: true

class AddInterchangableUniqueIndexToFriendships < ActiveRecord::Migration[5.2]
  def change
    reversible do |direction|
      direction.up do
        connection.execute('
          create unique index index_friendships_on_interchangable_user_id_and_friend_id on friendships(greatest(user_id, friend_id), least(user_id, friend_id));
          create unique index index_friendships_on_interchangable_friend_id_and_user_id on friendships(greatest(user_id, friend_id), least(user_id, friend_id));
          ')
      end
      direction.down do
        connection.execute('
          drop index index_friendships_on_interchangable_user_id_and_friend_id;
          drop index index_friendships_on_interchangable_friend_id_and_user_id;
          ')
      end
    end
  end
end
