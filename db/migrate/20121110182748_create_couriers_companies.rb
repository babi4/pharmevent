class CreateCouriersCompanies < ActiveRecord::Migration
  def change
    create_table :couriers_companies do |t|
      t.string :name
      t.string :zip_code
      t.string :city
      t.string :street
      t.string :house
      t.string :stroenie
      t.string :office

      t.timestamps
    end
  end
end
