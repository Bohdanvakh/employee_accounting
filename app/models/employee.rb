class Employee < ApplicationRecord
  belongs_to :department

  has_many :vacations
  has_many :position_histories
  has_many :positions, through: :position_histories

  validates :last_name, presence: { message: I18n.t('activerecord.errors.models.employee.attributes.last_name.blank') },
                          length: { minimum: 2, maximum: 30,
                            too_short: I18n.t('activerecord.errors.models.employee.attributes.last_name.too_short', count: 2),
                            too_long: I18n.t('activerecord.errors.models.employee.attributes.last_name.too_long', count: 30) }

  validates :first_name, presence: { message: I18n.t('activerecord.errors.models.employee.attributes.first_name.blank') },
                          length: { minimum: 2, maximum: 30,
                            too_short: I18n.t('activerecord.errors.models.employee.attributes.first_name.too_short', count: 2),
                            too_long: I18n.t('activerecord.errors.models.employee.attributes.first_name.too_long', count: 30) }

  validates :middle_name, presence: { message: I18n.t('activerecord.errors.models.employee.attributes.middle_name.blank') },
                          length: { minimum: 2, maximum: 30,
                            too_short: I18n.t('activerecord.errors.models.employee.attributes.middle_name.too_short', count: 2),
                            too_short: I18n.t('activerecord.errors.models.employee.attributes.middle_name.too_long', count: 30) }

  validates :passport_data, presence: { message: I18n.t('activerecord.errors.models.employee.attributes.passport_data.blank') },
                          length: { is: 9, message: I18n.t('activerecord.errors.models.employee.attributes.passport_data.is', count: 9) }

  validates :date_of_birth, presence: { message: I18n.t('activerecord.errors.models.employee.attributes.date_of_birth.blank') },
                          timeliness: { before: 18.years.ago, message: I18n.t('activerecord.errors.models.employee.attributes.date_of_birth.before',
                          restriction: 18.years.ago) }

  validates :place_of_birth, presence: { message: I18n.t('activerecord.errors.models.employee.attributes.place_of_birth.blank') },
                          format: { with: /\A[a-zA-Z\s]+\z/, message: I18n.t('activerecord.errors.models.employee.attributes.place_of_birth.invalid') }

  validates :home_address, presence: { message: I18n.t('activerecord.errors.models.employee.attributes.home_address.blank') },
                          format: { with: /\A\d+\s[A-z0-9]+\s[A-z]+\z/, message: I18n.t('activerecord.errors.models.employee.attributes.home_address.invalid') }

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
