# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    association :friend, factory: :user
    association :user
    confirmed { false }
  end
end
