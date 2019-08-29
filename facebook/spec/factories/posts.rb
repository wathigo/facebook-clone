FactoryBot.define do
  factory :post do
    title { "MyText" }
    content { Faker::Games::WorldOfWarcraft.quote }
  end
end
