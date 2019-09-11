# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { Faker::Games::WorldOfWarcraft.quote }
  end
end
