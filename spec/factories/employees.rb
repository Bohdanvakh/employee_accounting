FactoryBot.define do
  factory :employee, class: Employee do
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    passport_data { Faker::Number.number(digits: 9).to_s }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    place_of_birth { Faker::Address.city }
    home_address { Faker::Address.street_address }

    department

  end
end
