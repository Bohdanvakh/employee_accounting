class Employee < ApplicationRecord
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :middle_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :passport_data, presence: true, length: { is: 9 }
  validates :date_of_birth, presence: true, timeliness: { before: 18.years.ago }
  validates :place_of_birth, presence: true, format: { with: /\A[a-zA-Z\s]+\z/ }
  validates :home_address, presence: true, format: { with: /\A\d+\s[A-z0-9]+\s[A-z]+\z/ }
  validate :employed_on_in_past
end

def employed_on_in_past
  if employed_on.present? && employed_on >= Date.current
    errors.add(:employed_on, "must be in the past")
  end
end
