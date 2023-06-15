FactoryBot.define do
  factory :position_history do
    started_on { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    finished_on { Faker::Date.between(from: started_on, to: Date.today) }

    employee
    position
  end
end
