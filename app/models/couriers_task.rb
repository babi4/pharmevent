class CouriersTask < ActiveRecord::Base
  attr_accessible :from_couriers_company_id, :from_date, :name, :status, :telephone, :to_couriers_company_id, :to_date, :to_person

  validates :name, :from_couriers_company_id, :to_couriers_company_id, :presence => true
  validates :name, :uniqueness => true

  belongs_to :user

  belongs_to :to_couriers_company, :class_name => "CouriersCompany",
             :foreign_key => "to_couriers_company_id"

  belongs_to :from_couriers_company, :class_name => "CouriersCompany",
             :foreign_key => "from_couriers_company_id"

end
