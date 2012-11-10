class CreateDocumentsNalRashods < ActiveRecord::Migration
  def change
    create_table :documents_nal_rashods do |t|
      t.integer :user_id
      t.string :company
      t.string :description
      t.string :name
      t.string :telephone
      t.string :summ
      t.datetime :date
      t.string :lectors
      t.string :entire

      t.timestamps
    end
  end
end
