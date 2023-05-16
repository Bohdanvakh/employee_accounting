class PositionHistory < ApplicationRecord
  validates :started_on, presence: true
  validates :finished_on, presence: true
end
