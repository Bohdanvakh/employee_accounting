class Department < ApplicationRecord
  has_many :employees, dependent: :destroy

  validates :name, presence: { message: I18n.t('activerecord.errors.models.department.attributes.name.blank') },
                    uniqueness: { message: I18n.t('activerecord.errors.models.department.attributes.name.taken') },
                    length: { minimum: 6, maximum: 120,
                      too_short: I18n.t('activerecord.errors.models.department.attributes.name.too_short', count: 6),
                      too_long: I18n.t('activerecord.errors.models.department.attributes.name.too_long', count: 120) }

  validates :abbreviation, presence: { message: I18n.t('activerecord.errors.models.department.attributes.abbreviation.blank') },
                    length: { minimum: 40, maximum: 400,
                      too_short: I18n.t('activerecord.errors.models.department.attributes.abbreviation.too_short', count: 40),
                      too_long: I18n.t('activerecord.errors.models.department.attributes.abbreviation.too_long', count: 400) }
end
