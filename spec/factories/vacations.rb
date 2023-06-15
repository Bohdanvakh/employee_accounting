FactoryBot.define do
  factory :vacation do
    started_on { Faker::Date.between(from: Date.today, to: Date.today + 1.year) }
    finished_on { started_on employee.position_histories.last.vacation_days.days }

    employee
  end
end
