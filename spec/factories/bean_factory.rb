FactoryBot.define do
  factory :bean do
    name { Faker::Coffee.blend_name }
    origin { Faker::Coffee.origin }
    elevation { rand(10000) }

    association :roaster
  end
end
