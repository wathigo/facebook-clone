# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  name = Faker::Name.unique.name
  email = "example-#{n + 1}@railstutorial.org"
  password = "foobar123"
  User.create!(user_name: name,
               email: email,
               password: password)
end

users = User.order(:created_at).take(5)
users.each do |user|
  15.times do |_i|
    title = Faker::Book.title
    content = "Feeling awesome"
    user.created_posts.create!(title: title,
                                content: content)
  end
end
