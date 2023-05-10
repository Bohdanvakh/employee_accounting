class Position < ApplicationRecord
  belongs_to :employees
  has_many :position_histories

  validates :name, presence: true, length: { minimum: 8, maximum: 120 }
  validates :salary, presence: true
  validates :vacation_days, presence: true
end
