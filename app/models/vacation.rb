class Vacation < ApplicationRecord
  belongs_to :employee

  validates :started_on, presence: true
  validates :finished_on, presence: true
  validates :employee_id, presence: true, uniqueness: true
  validate :start_and_finish_dates
end

def start_and_finish_dates
  if  started_on && finished_on && started_on > finished_on
    errors.add(:finished_on, "Vacation cannot end before it begins")
  end
end
