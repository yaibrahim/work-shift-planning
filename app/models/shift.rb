class Shift < ApplicationRecord
  belongs_to :worker

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :date, presence: true
  validate :no_overlapping_shifts
  validate :valid_time_range

  private

  def no_overlapping_shifts
    if worker.shifts.where("date = ?", date).any?
      errors.add(:base, "Worker cannot have two shifts on the same day")
    end
  end

  def valid_time_range
    range_0_8 = (date.beginning_of_day..date.change(hour: 8, min: 0, sec: 0))
    range_8_16 = (date.change(hour: 8, min: 0, sec: 0)..date.change(hour: 16, min: 0, sec: 0))
    range_16_24 = (date.change(hour: 16, min: 0, sec: 0)..date.end_of_day)

    unless [range_0_8, range_8_16, range_16_24].any? { |range| range.cover?(start_time) && range.cover?(end_time) }
      errors.add(:base, "Shift time range is invalid. Must be within 0-8, 8-16, or 16-24.")
    end
  end
end
