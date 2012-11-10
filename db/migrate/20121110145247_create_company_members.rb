class CreateCompanyMembers < ActiveRecord::Migration
  def change
    create_table :company_members do |t|
      t.integer :company_id
      t.string :name
      t.string :telephone
      t.string :position
      t.string :email

      t.timestamps
    end
  end
end
