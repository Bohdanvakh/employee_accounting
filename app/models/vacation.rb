class Vacation < ApplicationRecord
  belongs_to :employee

  MAX_SIMULTANEOUS_VACATIONS = 5

  validates :started_on, presence: true
  validates :finished_on, presence: true, comparison: { greater_than: :started_on }
  validates :employee_id, presence: true
  validate :remaining_vacation_days, on: :create
  validate :not_past_date, on: :create
  validate :vacation_overlap, on: :create
  validate :position_active, on: :create
  validate :can_take_vacation, on: :create

  def remaining_vacation_days
    remaining_days = employee.vacation_days - employee.used_vacation_days
    return if remaining_days > 0
    errors.add(:base, :dont_have_enough_days)
  end

  def not_past_date
    return unless started_on && finished_on
    return if started_on > DateTime.now
    errors.add(:base, :past_date)
  end

  def vacation_overlap
    vacation_interval = started_on..finished_on
    if employee.vacations.where(started_on: vacation_interval).or(employee.vacations.where(finished_on: vacation_interval)).exists?
      errors.add(:base, :vacation_overlap)
    end
  end

  def position_active
    last_position_history = employee.position_histories.last
    if last_position_history.present? && last_position_history.finished_on.present?
      errors.add(:base, :position_finished)
    end
  end

  def can_take_vacation
    vacation_interval = started_on..finished_on
    overlapping_vacations = Vacation.joins(:employee)
                                    .where(employees: { department_id: employee.department.id })
                                    .where(vacations: { started_on: vacation_interval })
                          .or(Vacation.joins(:employee)
                                    .where(employees: { department_id: employee.department.id })
                                    .where(vacations: { finished_on: vacation_interval }))
                          .count
    errors.add(:base, :simultaneous_vacations_limit) if overlapping_vacations >= MAX_SIMULTANEOUS_VACATIONS
  end
end
