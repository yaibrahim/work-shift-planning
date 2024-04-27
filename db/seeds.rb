# Create Workers
7.times do |i|
    Worker.create(name: FFaker::Name.name)
end
  
# Create Shifts
start_dates = [Date.today, Date.tomorrow, Date.today + 2.days]
workers = Worker.all

start_dates.each do |start_date|
    workers.each do |worker|
        Shift.create(
        start_time: start_date.to_time + 8.hours, # Assuming the first shift starts at 8 AM
        end_time: start_date.to_time + 16.hours,  # Assuming the first shift ends at 4 PM
        date: start_date,
        worker_id: worker.id
        )
    end
end