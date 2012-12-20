class CouriersCompanyMember < ActiveRecord::Base
  attr_accessible :name, :telephone, :couriers_companies
  belongs_to :couriers_company

  has_many :to_couriers_tasks, :class_name => "CouriersTask",
           :foreign_key => "to_couriers_company_member_id"

  has_many :from_couriers_tasks, :class_name => "CouriersTask",
           :foreign_key => "from_couriers_company_member_id"

end
