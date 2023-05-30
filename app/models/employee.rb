class Employee < ApplicationRecord
  belongs_to :department

  has_many :vacations
  has_many :position_histories
  has_many :positions, through: :position_histories

  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :middle_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :passport_data, presence: true, length: { is: 9 }
  validates :date_of_birth, presence: true, timeliness: { before: 18.years.ago }
  validates :place_of_birth, presence: true, format: { with: /\A[a-zA-Z\s]+\z/ }
  validates :home_address, presence: true, format: { with: /\A\d+\s[A-z0-9]+\s[A-z]+\z/ }
  #validate :last_position_finished
  #validate :vacation_date_nil

  def vacation_days
    positions&.last&.vacation_days || 0
  end

  def remaining_vacation_days
    vacation_days - used_vacation_days
  end

  def years_of_employment
    return 0 unless started_last_position
    DateTime.now.year - started_last_position.year
  end

  def started_last_position
    position_histories.last&.started_on
  end

  def used_vacation_days
    return 0 unless started_last_position
    count = 0
    start = started_last_position + years_of_employment.years
    end_on = start + 1.year
    vacations.where(started_on: start..end_on).each do |vacation|
      count += (vacation.finished_on - vacation.started_on).to_i
    end
    count
  end

end
