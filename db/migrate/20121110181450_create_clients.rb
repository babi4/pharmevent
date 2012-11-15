class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.date :birthday
      t.string :passport_number
      t.string :zagran_passport_number
      t.date :zagran_passport_use_before
      t.string :degree
      t.string :position
      t.string :work
      t.text :notes

      t.timestamps
    end
  end
end
