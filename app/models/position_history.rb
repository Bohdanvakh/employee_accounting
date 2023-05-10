class PositionHistory < ApplicationRecord
  validates :started_on, presence: true
  validates :finished_on, presence: true
  validates :employee_id, presence: true, uniqueness: true
  validates :position_id, presence: true, uniqueness: true
end
