class Department < ApplicationRecord
  has_many :employees, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 6, maximum: 120 }
  validates :abbreviation, presence: true, length: { minimum: 40, maximum: 400 }
end
