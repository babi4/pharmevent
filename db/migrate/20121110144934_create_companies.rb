class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :events_id
      t.string :name
      t.string :company_type
      t.string :short_name
      t.string :ur_zip_code
      t.string :ur_city
      t.string :ur_street
      t.string :ur_hous
      t.string :ur_stroenie
      t.string :ur_office
      t.string :ur_post_equal
      t.string :post_zip_code
      t.string :post_city
      t.string :post_street
      t.string :post_house
      t.string :post_stroenie
      t.string :post_office
      t.string :telephone
      t.string :fax
      t.string :email
      t.integer :inn
      t.string :kpp
      t.string :ogrn
      t.string :okpo
      t.string :okved
      t.string :ispolnitel
      t.string :osnovanie_ispolnitel
      t.string :bakn_account
      t.string :bakn_corr_account
      t.string :bank_name
      t.string :bank_zip
      t.string :bank_city
      t.string :bank_street
      t.string :bank_house
      t.string :bank_stroenie
      t.string :bank_office
      t.string :bank_bik

      t.timestamps
    end
  end
end
