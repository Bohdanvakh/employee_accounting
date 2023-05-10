class Vacation < ApplicationRecord
  belongs_to :employees

  validates :started_on, presence: true
  validates :finished_on, presence: true
  validates :employee_id, presence: true
end
