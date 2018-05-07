FactoryBot.define do
  factory :roaster do
    name { Faker::Company.name }
    # association :location
  end
end
