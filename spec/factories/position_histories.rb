FactoryBot.define do
  factory :position_history, class: PositionHistory do
    started_on { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    finished_on { Faker::Date.between(from: started_on, to: Date.today) }

    association :employee
    association :position
  end
end
