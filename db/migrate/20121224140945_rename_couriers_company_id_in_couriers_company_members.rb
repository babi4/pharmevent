class RenameCouriersCompanyIdInCouriersCompanyMembers < ActiveRecord::Migration
  def up
    rename_column :couriers_company_members, :couriers_companies_id, :couriers_company_id
  end

  def down
    rename_column :couriers_company_members, :couriers_company_id, :couriers_companies_id
  end
end
