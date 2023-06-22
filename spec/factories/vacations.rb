FactoryBot.define do
  factory :vacation, class: Vacation do
    started_on { DateTime.now + 1.day }
    finished_on { DateTime.now + 3.days }

    employee {
      employee = FactoryBot.create(:employee)
      FactoryBot.create(:position_history, employee: employee, finished_on: nil)
      employee
    }
  end
end
