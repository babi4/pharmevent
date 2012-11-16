class CreateDocumentsBeznalSchets < ActiveRecord::Migration
  def change
    create_table :documents_beznal_schets do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :company_id

      t.string :description
      t.string :name
      t.string :telephone
      t.integer :num_schet
      t.date :date_schet
      t.integer :summ
      t.integer :nds
      t.integer :dogovor_num
      t.date :dogovor_date
      t.date :payment_date


      t.string :info_schet_factura
      t.string :info_act
      t.date :info_date_schet
      t.date :info_date_act
      t.string :info_state_act
      t.date :info_return_date
      t.string :info_type_return_act
      t.string :info_name_sender

      t.timestamps
    end
  end
end
