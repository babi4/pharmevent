class FixCompaniesTypo1 < ActiveRecord::Migration
  def change
    rename_column :companies, :ur_hous, :ur_house
  end
end
