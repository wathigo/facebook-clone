# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    content { Faker::Games::WorldOfWarcraft.quote }
  end
end
