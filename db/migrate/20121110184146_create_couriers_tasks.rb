class CreateCouriersTasks < ActiveRecord::Migration
  def change
    create_table :couriers_tasks do |t|
      t.integer :user_id
      t.string :name
      t.string :telephone
      t.string :from_date
      t.string :to_date
      t.string :status
      t.string :to_person
      t.string :from_couriers_company_id
      t.string :to_couriers_company_id

      t.timestamps
    end
  end
end
