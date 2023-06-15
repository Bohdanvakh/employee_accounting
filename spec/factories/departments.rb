FactoryBot.define do
  factory :department do
    sequence(:name) { |n| Faker::Lorem.name }
    sequence(:abbreviation) { |n| "#{Faker::Lorem.abbreviation}#{n}" }
  end
end
