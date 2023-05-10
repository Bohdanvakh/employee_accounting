class Position < ApplicationRecord
  validates :name, presence: true, length: { minimum: 8, maximum: 120 }
  validates :salary, presence: true, greater_than: 0
  validates :vacation_days, presence: true
end
