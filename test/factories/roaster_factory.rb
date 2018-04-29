FactoryBot.define do
  factory :roaster do
    name { Faker::Company.name }
    association :location, factory: :location
  end
end
