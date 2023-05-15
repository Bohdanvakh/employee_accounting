class PositionHistory < ApplicationRecord
  validates :started_on, presence: true
  validates :finished_on, presence: true
  validates :employee_id, uniqueness: { scope: [:position_id] }
  validates :position_id, presence: true, uniqueness: true
end
