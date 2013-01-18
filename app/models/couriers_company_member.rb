class CouriersCompanyMember < ActiveRecord::Base
  attr_accessible :name, :telephone, :couriers_companies
  belongs_to :couriers_company

end
