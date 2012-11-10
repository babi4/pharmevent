class CompanyMember < ActiveRecord::Base
  attr_accessible :company_id, :email, :name, :position, :telephone
end
