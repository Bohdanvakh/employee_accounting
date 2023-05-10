class Employee < ApplicationRecord
  has_many :positions
  has_many :vacations

  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :middle_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :passport_data, presence: true, length: { is: 9 }
  validates :date_of_birth, presence: true
  validates :place_of_birth, presence: true
  validates :home_address, presence: true
  validates :employed_on, presence: true
  validates :salary, presence: true
  validate :date_of_birth_validation
  validate :employed_on_valid
end

def date_of_birth_validation
  if date_of_birth > Date.today
    errors.add(:date_of_birth, "Date of birth can't be in the future")
  end
end

def employed_on_valid
  if employed_on > Date.today
    errors.add(:employed_on, "The employee could not be employed on this date")
  end
end
