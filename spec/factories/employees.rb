FactoryBot.define do
  factory :employee, class: Employee do
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    passport_data { Faker::Number.number(digits: 9).to_s }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    place_of_birth { Faker::Address.city.gsub(/[0-9]/, '') }
    home_address { "123 Main Street" }

    association :department
  end
end
