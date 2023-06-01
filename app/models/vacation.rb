class Vacation < ApplicationRecord
  belongs_to :employee

  validates :started_on, presence: true
  validates :finished_on, presence: true, comparison: { greater_than: :started_on }
  validates :employee_id, presence: true
  validate :remaining_vacation_days
  validate :not_past_date
  validate :vacation_overlap
  validate :position_active
  validate :can_take_vacation

  def remaining_vacation_days
    remaining_days = employee.vacation_days - employee.used_vacation_days
    return if remaining_days > 0
    errors.add(:vacation_days, "Dont have enough days")
  end

  def not_past_date
    return unless started_on && finished_on
    return if started_on > DateTime.now
    errors.add(:vacation_days, "You cannot take vacation in a past date")
  end

  def vacation_overlap
    employee.vacations.each do |vacation|
      vacation_interval = vacation.started_on..vacation.finished_on
      if vacation_interval.cover?(started_on) || vacation_interval.cover?(finished_on)
        errors.add(:vacation_days, "Vacation cannot overlap with other vacations")
      end
    end
  end

  def position_active
    last_position_history = employee.position_histories.last
    if last_position_history.present? && last_position_history.finished_on.present?
      errors.add(:vacation_days, "You can't add vacation because the last position is already finished.")
    end
  end

  def can_take_vacation
    department = employee.department
    all_employees = department.employees
    count = 0
    all_employees.each do |employee|
      employee.vacations.each do |vacation|
        vacation_interval = vacation.started_on..vacation.finished_on
        count += 1 if vacation_interval.cover?(started_on) || vacation_interval.cover?(finished_on)
        errors.add(:base, "You cannot take a vacation on this dates because 5 employees have already taken it.") if count == 5
      end
    end
  end

end
