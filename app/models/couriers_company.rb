class CouriersCompany < ActiveRecord::Base
  attr_accessible :full_address, :city, :house, :name, :office, :street, :stroenie, :zip_code
  attr_accessor :full_address

  has_many :couriers_company_members

  validates :name, :presence => true, :uniqueness => true

  def company_members
    self.couriers_company_members
  end

end
