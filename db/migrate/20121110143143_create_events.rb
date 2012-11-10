class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :user_id
      t.integer :company_id
      t.date :date_start
      t.date :date_end
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
