class AddOkatoToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :okato, :string
  end
end
