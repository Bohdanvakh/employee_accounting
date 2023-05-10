class Employee < ApplicationRecord
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :middle_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :passport_data, presence: true, length: { is: 9 }
  validates :date_of_birth, presence: true, date: { before: 18.years.ago }
  validates :place_of_birth, presence: true, format: { with: /\A[a-zA-Z\s]+\z/ }
  validates :home_address, presence: true, format: { with: /\A\d+\s[A-z0-9]+\s[A-z]+\z/ }
  validates :employed_on, presence: true, date: { before: -> Date.current }
  validates :salary, presence: true, greater_than: 0
end
