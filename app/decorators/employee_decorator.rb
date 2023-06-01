class EmployeeDecorator < Draper::Decorator
  delegate_all

  def initialize(employee)
    @employee = employee
  end

  SALARY_INCREASE_RATE = 0.012

  def calculate_salary
    unless @employee.positions.empty?
      base_salary = @employee.positions.last.salary
      years_of_service = years_of_employee

      increased_salary = (base_salary * (1 + SALARY_INCREASE_RATE)**years_of_service).to_i
    end
  end

  def years_of_employee
    total_days = 0
    @employee.position_histories.each do |position|
      if position.finished_on.present?
        total_days += (position.finished_on - position.started_on).to_i
      else
        total_days += (DateTime.now - position.started_on).to_i
      end
    end
    total_days
    total_years = total_days / 365
    total_years
  end
end
