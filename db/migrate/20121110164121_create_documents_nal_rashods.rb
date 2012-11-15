class CreateDocumentsNalRashods < ActiveRecord::Migration
  def change
    create_table :documents_nal_rashods do |t|
      t.integer :user_id
      t.integer :event_id

      t.string :company
      t.string :description
      t.string :name
      t.string :telephone
      t.integer :summ
      t.date :date

      t.boolean :lectors, :default => false, :null => false
      t.boolean :entire, :default => false, :null => false

      t.timestamps
    end
  end
end
