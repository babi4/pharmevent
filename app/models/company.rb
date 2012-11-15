class Company < ActiveRecord::Base
  attr_accessible :bank_account, :bank_corr_account, :bank_bik, :bank_city, :bank_house, :bank_name, :bank_office, :bank_street, :bank_stroenie, :bank_zip, :company_type, :email, :fax, :inn, :ispolnitel, :kpp, :name, :ogrn, :okpo, :okved, :osnovanie_ispolnitel, :post_city, :post_house, :post_office, :post_street, :post_stroenie, :post_zip_code, :short_name, :telephone, :ur_city, :ur_hous, :ur_office, :ur_post_equal, :ur_street, :ur_stroenie, :ur_zip_code
  has_many :events
  has_many :company_members
  has_many :documents_beznal_schets

  validates :name, :presence => true
  validates :name, :uniqueness => true

end
