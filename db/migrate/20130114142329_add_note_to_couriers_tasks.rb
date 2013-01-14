class AddNoteToCouriersTasks < ActiveRecord::Migration
  def change
    add_column :couriers_tasks, :note, :string
  end
end
