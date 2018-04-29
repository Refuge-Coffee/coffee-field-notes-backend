FactoryBot.define do
  factory :location do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    website { Faker::Internet.url }
    rating { rand(1..10) }
    association :roaster
  end
end
