class Department < ApplicationRecord
  has_many :employees
  has_many :positions, through: :employees

  validates :name, presence: true, uniqueness: true, length: { minimum: 6, maximum: 120 }
  validates :abbreviation, presence: true, uniqueness: true, length: { minimum: 40, maximum: 400 }
  validates :max_employees, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 20 }
  validates :employees_on_vacation, numericality: { only_integer: true, less_than_or_equal_to: 5 }
  validates :manager_id, presence: true
end
