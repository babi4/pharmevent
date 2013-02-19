class CouriersCompanyMember < ActiveRecord::Base
  acts_as_paranoid

  attr_accessible :name, :telephone, :couriers_companies
  belongs_to :couriers_company

end
