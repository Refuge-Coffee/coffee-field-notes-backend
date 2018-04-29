FactoryBot.define do
  factory :location do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    elevation { rand(10000) }
  end
end
