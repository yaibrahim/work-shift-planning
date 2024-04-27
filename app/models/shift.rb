class Shift < ApplicationRecord
  belongs_to :worker

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :date, presence: true
  validate :no_overlapping_shifts

  private

  def no_overlapping_shifts
    if worker.shifts.where("date = ? AND start_time <= ? AND end_time >= ?", date, end_time, start_time).any?
      errors.add(:base, "Worker cannot have two shifts on the same day")
    end
  end
end
