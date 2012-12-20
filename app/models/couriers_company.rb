class CouriersCompany < ActiveRecord::Base
  attr_accessible :city, :house, :name, :office, :street, :stroenie, :zip_code
  has_many :couriers_company_members

  validates :name, :presence => true, :uniqueness => true

  has_many :to_couriers_tasks, :class_name => "CouriersTask",
           :foreign_key => "to_couriers_company_id"

  has_many :from_couriers_tasks, :class_name => "CouriersTask",
           :foreign_key => "from_couriers_company_id"

end
