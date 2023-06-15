FactoryBot.define do
  factory :position do
    name { Faker::Job.title }
    salary { Faker::Number.between(from: 1000, to: 10000) }
    vacation_days { Faker::Number.between(from: 5, to: 30) }
  end
end
