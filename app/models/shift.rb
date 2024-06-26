class Shift < ApplicationRecord
  belongs_to :worker

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :date, presence: true
  validate :no_overlapping_shifts
  validate :valid_time_range
  validate :eight_hours_long_shift

  private

  # A worker never has two shifts on the same day.
  def no_overlapping_shifts
    if self.new_record? && worker.present? && worker.shifts.where(date: date).any?
      errors.add(:base, "Worker cannot have two shifts on the same day")
    end
  end

  # It is a 24 hour timetable 0-8, 8-16, 16-24.
  def valid_time_range
    if date.present? && end_time.present? && start_time.present?
      range_0_8 = (date.beginning_of_day.hour..(date.beginning_of_day + 8.hours).hour)
      range_8_16 = ((date.beginning_of_day + 8.hours).hour..(date.beginning_of_day + 16.hours).hour)
      range_16_24 = ((date.beginning_of_day + 16.hours).hour..24)

      end_hour = 0
      end_time = Time.parse(self.end_time.to_s)

      if end_time.hour == 23 && end_time.min == 59 && end_time.sec == 59
        end_hour = 24
      else
        end_hour = self.end_time.hour
        end_hour = end_time.hour == 0 ? 24 : end_time.hour
      end

      unless [range_0_8, range_8_16, range_16_24].any? { |range| range.first == start_time.hour && range.last == end_hour }
        errors.add(:base, "Shift time range is invalid. Must be within 0-8, 8-16, or 16-24.")
      end
    end
  end

  # A shift is 8 hours long
  def eight_hours_long_shift
    if end_time.present? && start_time.present?
      time_diff = 0
      time_diff = ((end_time - start_time) / 3600).abs if !start_time.blank? && !end_time.blank?
      time_diff = time_diff.ceil if end_time.hour == 23 && end_time.min == 59 && end_time.sec == 59
      errors.add(:base, "Time duration must be equal to 8 hours") if time_diff < 8
    end
  end
end
