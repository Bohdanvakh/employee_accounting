class PositionHistory < ApplicationRecord
  belongs_to :employee
  belongs_to :position

  validates :started_on, presence: true
  validate :last_position_finished, on: create
  validate :manager_exists, on: create
  validate :validate_position_history_overlap, on: create

  def last_position_finished
    employee_position_histories = PositionHistory.where(employee_id: employee_id)
    return if employee_position_histories.blank?

    if employee_position_histories.order(id: :desc).take(1).pluck(:finished_on).first.nil?
      errors.add(:base, "The last position is active")
    end
  end

  def validate_position_history_overlap
    vacation_interval = started_on..finished_on
    if employee.position_histories.where.not(finished_on: nil)
                                  .where(started_on: vacation_interval)
                                  .or(employee.position_histories.where.not(finished_on: nil)
                                  .where(finished_on: vacation_interval)).exists?
      errors.add(:base, "Position cannot overlap with other positions")
    end
  end

  def manager_exists
    # binding.pry
    department = employee.department
    department.employees.each do |employee|
      return if employee.position_histories.blank?
      # if employee.position_histories.present? && employee.position_histories.last.finished_on == nil && employee.position_histories.last.position.name == Position::MANAGER
      if employee.position_histories.last.finished_on == nil && employee.position_histories.last.position.name == Position::MANAGER
        errors.add(:base, "The position is already taken")
      end
    end
  end

end
