# encoding: utf-8

module CouriersTasksHelper
  def courier_company_address(company)
    address = "#{company.zip_code}, г.#{company.city}, ул.#{company.street}, дом #{company.house}"
    address += ", строение #{company.stroenie}" unless company.stroenie.blank?
    address += ", офис #{company.office}" unless company.office.blank?
    address
  end

  def courier_map_address(company)
    unless company.city.blank? or company.street.blank? or company.house.blank?
      "#{company.city}, #{company.street}, #{company.house}"
    end
  end
end
