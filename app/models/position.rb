class Position < ApplicationRecord
  has_many :position_histories, dependent: :destroy
  has_many :employees, through: :position_histories

  MANAGER = "manager"

  validates :name, presence: { message: :blank },
                    length: { minimum: 4, maximum: 120,
                      too_short: :too_short, count: 4,
                      too_long: :too_long, count: 120 }

  validates :salary, presence: { message: :blank },
                    numericality: { greater_than: 0,
                      message: :greater_than }

  validates :vacation_days, presence: { message: :blank },
                    numericality: { only_integer: true,
                      message: :not_an_integer }
end
