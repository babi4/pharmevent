class AddDueTimeToCouriersTasks < ActiveRecord::Migration
  def change
    add_column :couriers_tasks, :due_time, :datetime
  end
end
