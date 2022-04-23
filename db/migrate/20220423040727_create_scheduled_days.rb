class CreateScheduledDays < ActiveRecord::Migration[6.0]
  def change
    create_table :scheduled_days do |t|

      t.timestamps
    end
  end
end
