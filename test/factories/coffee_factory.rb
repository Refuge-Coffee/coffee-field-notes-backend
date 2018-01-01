FactoryBot.define do
  factory :coffee do
    name { Faker::Coffee.blend_name }
    origin { Faker::Coffee.origin }
    elevation { rand(10000) }
  end
end
