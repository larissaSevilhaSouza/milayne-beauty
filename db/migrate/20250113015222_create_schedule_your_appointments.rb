class CreateScheduleYourAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :schedule_your_appointments do |t|
      t.string :photo
      t.string :description
      t.string :number

      t.timestamps
    end
  end
end
