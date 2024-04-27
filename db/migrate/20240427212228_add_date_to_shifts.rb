class AddDateToShifts < ActiveRecord::Migration[7.0]
  def change
    add_column :shifts, :date, :date
  end
end
