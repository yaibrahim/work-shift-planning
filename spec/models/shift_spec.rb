require 'rails_helper'

RSpec.describe Shift, type: :model do
  let(:worker) { Worker.create(name: 'Test Worker') }
  describe 'validations' do
    it 'requires start_time' do
      shift = Shift.new(end_time: Time.now, date: Date.today, worker: worker)
      expect(shift).not_to be_valid
      expect(shift.errors[:start_time]).to include("can't be blank")
    end

    it 'requires end_time' do
      shift = Shift.new(start_time: Time.now, date: Date.today, worker: worker)
      expect(shift).not_to be_valid
      expect(shift.errors[:end_time]).to include("can't be blank")
    end

    it 'requires date' do
      shift = Shift.new(start_time: Time.now, end_time: Time.now + 1.hour, worker: worker)
      expect(shift).not_to be_valid
      expect(shift.errors[:date]).to include("can't be blank")
    end

    it 'checks for overlapping shifts' do
      shift_test = Shift.create(worker: worker, start_time: "2024-04-29T00:00:00", end_time: "2024-04-29T08:00:00", date: "2024-04-29")
      overlapping_shift = Shift.new(worker: worker, start_time: "2024-04-29T08:00:00", end_time: "2024-04-29T16:00:00", date: "2024-04-29")
      expect(overlapping_shift).not_to be_valid
      expect(overlapping_shift.errors[:base].join).to include("Worker cannot have two shifts on the same day")
    end

    it 'checks for valid time range' do
      shift = Shift.new(worker: worker, start_time: "2024-04-29T01:00:00", end_time: "2024-04-29T10:00:00", date: "2024-04-29")
      expect(shift).not_to be_valid
      expect(shift.errors[:baend_timese].join).to include("Shift time range is invalid. Must be within 0-8, 8-16, or 16-24.")
    end

    it 'checks for an 8-hour long shift' do
      shift = Shift.new(worker: worker, start_time: "2024-04-29T01:00:00", end_time: "2024-04-29T08:00:00", date: "2024-04-29")
      expect(shift).not_to be_valid
      expect(shift.errors[:base]).to include("Time duration must be equal to 8 hours")
    end
  end
end
