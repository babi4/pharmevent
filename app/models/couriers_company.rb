class CouriersCompany < ActiveRecord::Base
  acts_as_paranoid

  attr_accessible :full_address, :city, :house, :name, :office, :street, :stroenie, :zip_code
  attr_accessor :full_address

  has_many :couriers_company_members, :dependent => :destroy

  validates :name, :presence => true

  validates_as_paranoid
  validates_uniqueness_of_without_deleted :name

  def company_members
    self.couriers_company_members
  end

end
