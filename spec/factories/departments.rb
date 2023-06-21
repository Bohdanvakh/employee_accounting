FactoryBot.define do
  factory :department, class: Department do
    name { Faker::Name.unique.name }
    abbreviation { Faker::Lorem.unique.characters(number: 40) }
  end
end
