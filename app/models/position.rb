class Position < ApplicationRecord
  has_many :position_histories, dependent: :destroy
  has_many :employees, through: :position_histories

  MANAGER = "manager"

  validates :name, presence: { message: I18n.t('activerecord.errors.models.position.attributes.name.blank') },
                    length: { minimum: 4, maximum: 120,
                      too_short: I18n.t('activerecord.errors.models.position.attributes.name.too_short', count: 4),
                      too_long: I18n.t('activerecord.errors.models.position.attributes.name.too_long', count: 120) }

  validates :salary, presence: { message: I18n.t('activerecord.errors.models.position.attributes.salary.blank') },
                    numericality: { greater_than: 0,
                      message: I18n.t('activerecord.errors.models.position.attributes.salary.greater_than') }

  validates :vacation_days, presence: { message: I18n.t('activerecord.errors.models.position.attributes.activerecord.errors.models.position.attributes.vacation_days.not_an_integer.blank') },
                    numericality: { only_integer: true,
                      message: I18n.t('activerecord.errors.models.position.attributes.vacation_days.not_an_integer') }
end
