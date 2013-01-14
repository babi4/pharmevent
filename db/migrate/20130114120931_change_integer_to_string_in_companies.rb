class ChangeIntegerToStringInCompanies < ActiveRecord::Migration
  def up
    change_column :companies, :inn, :string
    change_column :companies, :ur_zip_code, :string
    change_column :companies, :post_zip_code, :string
    change_column :companies, :bank_zip, :string
  end

  def down
    change_column :companies, :inn, :integer
    change_column :companies, :ur_zip_code, :integer
    change_column :companies, :post_zip_code, :integer
    change_column :companies, :bank_zip, :integer
  end
end
