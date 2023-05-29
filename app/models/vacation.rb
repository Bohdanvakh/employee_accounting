class Vacation < ApplicationRecord
  belongs_to :employee

  validates :started_on, presence: true, comparison: { greater_than: :finished_on }
  validates :finished_on, presence: true
  validates :employee_id, presence: true
  validate :validate_remaining_vacation_days
  validate :validate_not_past_date
  validate :validate_vacation_overlap
  validate :validate_position_active

  def validate_remaining_vacation_days
    remaining_days = employee.vacation_days - employee.used_vacation_days
    return if remaining_days > 0
    errors.add(:vacation_days, "Dont have enough days")
  end

  def validate_not_past_date
    return unless started_on && finished_on
    return if started_on > DateTime.now
    errors.add(:vacation_days, "You cannot take vacation in a past date")
  end

  def validate_vacation_overlap
    if employee.vacations.present?
      employee.vacations.each do |vacation|
        vacation_interval = vacation.started_on..vacation.finished_on
        if vacation_interval.cover?(started_on) || vacation_interval.cover?(finished_on)
          errors.add(:vacation_days, "Vacation cannot overlap with other vacations")
        end
      end
    end
  end

  def validate_position_active
    last_position_history = employee.position_histories.last
    if last_position_history.present? && last_position_history.finished_on.present?
      errors.add(:vacation_days, "You can't add vacation because the last position is already finished.")
    end
  end
end
