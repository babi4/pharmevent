class CreateDocumentBeznalSchets < ActiveRecord::Migration
  def change
    create_table :document_beznal_schets do |t|
      t.integer :user_id
      t.string :company
      t.string :description
      t.string :name
      t.string :telephone
      t.string :num_schet
      t.string :date_schet
      t.string :summ
      t.integer :dogovor_num
      t.string :dogovor_date
      t.string :info_schet_factura
      t.string :info_act
      t.datetime :info_date_schet
      t.datetime :info_date_act
      t.string :info_state_act
      t.datetime :info_return_date
      t.datetime :info_return_act_type
      t.string :info_name_sender

      t.timestamps
    end
  end
end
