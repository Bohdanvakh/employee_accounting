class PositionHistory < ApplicationRecord
  belongs_to :employee
  belongs_to :position

  validates :started_on, presence: true
  validate :last_position_finished, on: :create
  validate :manager_exists, on: :create
  validate :validate_position_history_overlap, on: :create

  def last_position_finished
    employee = Employee.find_by_id(employee_id)
    position = employee.position_histories.last
    if position.present? && position.finished_on.nil?
      errors.add(:base, "The last position is active")
    end
  end

  def validate_position_history_overlap
    employee = Employee.find_by_id(employee_id)

    if employee.position_histories.present? && !employee.position_histories.last.finished_on.nil?
      employee.position_histories.each do |position|
        position_interval = position.started_on..position.finished_on
        if position_interval.cover?(started_on) || position_interval.cover?(finished_on)
          errors.add(:base, "Position cannot overlap with other positions")
        end
      end
    end
  end

  def manager_exists
    department = employee.department

    department.employees.each do |employee|
      if employee.position_histories.present? && employee.position_histories.last.finished_on == nil && employee.position_histories.last.position.name == "manager"
        errors.add(:base, "The position is already taken")
      end
    end
  end

end
