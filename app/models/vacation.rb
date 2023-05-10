class Vacation < ApplicationRecord
  validates :started_on, presence: true, date: true
  validates :finished_on, presence: true, date: true
  validates :employee_id, presence: true, uniqueness: true
end
