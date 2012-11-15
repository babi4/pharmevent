class CreateCouriersTasks < ActiveRecord::Migration
  def change
    create_table :couriers_tasks do |t|
      t.integer :user_id
      t.string :name
      t.string :telephone
      t.date :from_date
      t.date :to_date
      t.string :status
      t.string :to_person
      t.integer :from_couriers_company_id
      t.integer :to_couriers_company_id

      t.timestamps
    end
  end
end
