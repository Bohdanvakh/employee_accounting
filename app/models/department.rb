class Department < ApplicationRecord
  has_many :employees, dependent: :destroy

  validates :name, presence: { message: :blank },
                    uniqueness: { message: :taken },
                    length: { minimum: 6, maximum: 120,
                      too_short: :too_short, count: 6,
                      too_long: :too_long, count: 120 }

  validates :abbreviation, presence: { message: :blank },
                    length: { minimum: 40, maximum: 400,
                      too_short: :too_short, count: 40,
                      too_long: :too_long, count: 400 }
end
