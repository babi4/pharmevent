class CouriersTask < ActiveRecord::Base
  attr_accessible :from_couriers_company_id, :from_date, :name, :status, :telephone, :to_couriers_company_id, :to_date, :to_person, :user_id
end
