FactoryBot.define do
  factory :note do
    content { Faker::Lorem.paragraph(5) }
    time_of_day { ["Morning", "Mid-Day", "Afternoon", "Evening"].sample }
    association :bean, factory: :bean
  end
end
