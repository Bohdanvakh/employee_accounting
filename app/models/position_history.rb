class PositionHistory < ApplicationRecord
  belongs_to :employees
  belongs_to :positions

  validates :started_on, presence: true
  validates :finished_on, presence: true
  validates :employee_id, presence: true
  validates :position_id, presence: true
end
