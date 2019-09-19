# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |n|
  name = Faker::Name.unique.name
  email = "example-#{n + 1}@facebook.org"
  password = 'foobar'
  User.create!(user_name: name,
               email: email,
               password: password)
end

users1 = User.order(:created_at).take(10)
users2 = User.order(:created_at).reverse.take(10)

users1.each_with_index do |user1, index|
  users2[0, 5].each do |user2|
    if index > 4
      Friendship.create!(user_id: user2.id, friend_id: user1.id, confirmed: true)
    else
      Friendship.create!(user_id: user2.id, friend_id: user1.id, confirmed: false)
    end
  end
end

10.times do |i|
  4.times do |_j|
    content1 = Faker::Games::WorldOfWarcraft.quote
    content2 = Faker::Games::WorldOfWarcraft.quote
    users1[i].created_posts.create!(content: content1)
    users2[i].created_posts.create!(content: content2)
  end
end

user = users1[0]
posts = Post.all

posts.each do |post|
  4.times do |_j|
    content = Faker::Games::WorldOfWarcraft.quote
    post.comments.create!(content: content, user_id: user.id)
  end
end
