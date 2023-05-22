class Position < ApplicationRecord
  has_many :position_histories
  has_many :employees, through: :position_histories

  validates :name, presence: true, length: { minimum: 8, maximum: 120 }
  validates :salary, presence: true, numericality: { greater_than: 0 }
  validates :vacation_days, presence: true, numericality: { only_integer: true }
end
