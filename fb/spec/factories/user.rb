# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    user_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'test123' }
  end
end
