# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    for_post

    trait :for_comment do
      association(:likeable, factory: :comment)
    end

    trait :for_post do
      association(:likeable, factory: :post)
    end
    association :user
  end
end
