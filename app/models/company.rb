class Company < ActiveRecord::Base
  attr_accessible :bakn_account, :bakn_corr_account, :bank_bik, :bank_city, :bank_house, :bank_name, :bank_office, :bank_street, :bank_stroenie, :bank_zip, :company_type, :email, :events_id, :fax, :inn, :ispolnitel, :kpp, :name, :ogrn, :okpo, :okved, :osnovanie_ispolnitel, :post_city, :post_house, :post_office, :post_street, :post_stroenie, :post_zip_code, :short_name, :telephone, :ur_city, :ur_hous, :ur_office, :ur_post_equal, :ur_street, :ur_stroenie, :ur_zip_code
end
