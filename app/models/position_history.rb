class PositionHistory < ApplicationRecord
  belongs_to :employee
  belongs_to :position

  validates :started_on, presence: true
  validates :finished_on, presence: true
end
