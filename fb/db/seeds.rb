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

10.times do |i|
  unless i < 6
    Friendship.create!(user_id: users2[i].id, friend_id: users1[i].id, confirmed: true)
  else
    Friendship.create!(user_id: users2[i].id, friend_id: users1[i].id, confirmed: false)
  end
end

10.times do |i|
  8.times do |_j|
    content1 = Faker::Games::WorldOfWarcraft.quote
    content2 = Faker::Games::WorldOfWarcraft.quote
    users1[i].created_posts.create!(content: content1)
    users2[i].created_posts.create!(content: content2)
  end
end

users1.each do |user|
  user.created_posts.each do |post|
    10.times do |_i|
      content = Faker::Games::WorldOfWarcraft.quote
      user.comments.create!(content: content, post_id: post.id)
    end
  end
end
