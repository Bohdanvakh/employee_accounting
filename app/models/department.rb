class Department < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 6, maximum: 120 }
  validates :abbreviation, presence: true, uniqueness: true, length: { minimum: 40, maximum: 400 }
  validates :manager_id, presence: true, uniqueness: true
end
