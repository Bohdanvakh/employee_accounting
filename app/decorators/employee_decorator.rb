class EmployeeDecorator < Draper::Decorator
  delegate_all

  SALARY_INCREASE_RATE = 0.012

  def calculate_salary
    return 0 if positions.empty?
    base_salary = positions.last.salary
    years_of_service = years_of_employee

    increased_salary = (base_salary * (1 + SALARY_INCREASE_RATE)**years_of_service).to_i
  end

  def years_of_employee
    total_days = 0
    position_histories.each do |position|
      duration = position.finished_on? ? (position.finished_on - position.started_on).to_i : (DateTime.now - position.started_on).to_i
      total_days += duration
    end

    total_years = total_days / 365
    total_years
  end

  def total_vacation_days
    vacations.sum { |vacation| (vacation.finished_on - vacation.started_on).to_i }
  end

  def last_position
    unless position_histories.first.nil?
      position_histories.last.position.name
    end
  end
end
