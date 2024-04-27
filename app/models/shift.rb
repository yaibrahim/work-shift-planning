class Shift < ApplicationRecord
  belongs_to :worker

  validates :start_time, :end_time, presence: true
  validate :no_overlapping_shifts

  private

  def no_overlapping_shifts
    if worker.shifts.where("start_time <= ? AND end_time >= ?", end_time, start_time).any?
      errors.add(:base, "Worker cannot have two shifts on the same day")
    end
  end
end
