class CreateCouriersCompanyMembers < ActiveRecord::Migration
  def change
    create_table :couriers_company_members do |t|
      t.string :name
      t.belongs_to :couriers_companies
      t.string :telephone
    end
    remove_column :couriers_tasks, :telephone
    remove_column :couriers_tasks, :to_person

    add_column :couriers_tasks, :to_couriers_company_member_id, :integer
    add_column :couriers_tasks, :from_couriers_company_member_id, :integer

  end
end
