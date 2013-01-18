class ReWriteCouriersTasks < ActiveRecord::Migration

  def up

    change_table :couriers_tasks do |t|
      t.string :from_couriers_company_class # CouriersCompany
      t.string :to_couriers_company_class   # CouriersCompany
      t.string :from_couriers_company_member_class # CouriersCompanyMember
      t.string :to_couriers_company_member_class   # CouriersCompanyMember
    end

    CouriersTask.reset_column_information

    CouriersTask.all.each do |product|
      product.update_attributes!(
        from_couriers_company_class: 'CouriersCompany',
        to_couriers_company_class: 'CouriersCompany',
        from_couriers_company_member_class: 'CouriersCompanyMember',
        to_couriers_company_member_class: 'CouriersCompanyMember'
      )
    end

  end

  def down

    change_table :couriers_tasks do |t|
      t.remove :from_couriers_company_class
      t.remove :to_couriers_company_class
      t.remove :from_couriers_company_member_class
      t.remove :to_couriers_company_member_class
    end

  end
end
