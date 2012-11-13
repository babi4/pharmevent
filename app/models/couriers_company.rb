class CouriersCompany < ActiveRecord::Base
  attr_accessible :city, :house, :name, :office, :street, :stroenie, :zip_code

  validates :name, :presence => true
  validates :name, :uniqueness => true

end
