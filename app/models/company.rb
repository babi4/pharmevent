class Company < ActiveRecord::Base
  attr_accessible :bank_account, :bank_corr_account, :bank_bik, :bank_city, :bank_house, :bank_name, :bank_office, :bank_street, :bank_stroenie, :bank_zip, :company_type, :email, :fax, :inn, :ispolnitel, :kpp, :name, :ogrn, :okpo, :okved, :okato, :osnovanie_ispolnitel, :post_city, :post_house, :post_office, :post_street, :post_stroenie, :post_zip_code, :short_name, :telephone, :ur_city, :ur_hous, :ur_office, :ur_post_equal, :ur_street, :ur_stroenie, :ur_zip_code
  has_many :events
  has_many :company_members
  has_many :documents_beznal_schets

  validates :name, :ur_zip_code, :ur_city, :ur_street, :ur_hous, :presence => true
  validates :name, :uniqueness => true

#:post_city, :post_house, :post_office, :post_street, :post_stroenie, :post_zip_code

#:city, :house, :office, :street, :stroenie, :zip_code :name
  after_create do |company|
    attrs = {}
    %w(city house office street stroenie zip_code).each do |attr_name|
      attrs[attr_name] = company["post_#{attr_name}"]
    end
    attrs['name'] = "#{company[:company_type]} '#{company[:name]}'"

    CouriersCompany.find_or_create_by_name(attrs) # TODO verify only by name?
  end

  def transferred_funds
    self_id = self[:id] # yes, it is necessary
    company_events = Event.where{ company_id == self_id }
    DocumentsNalPrihod.where{event_id.in(company_events.select{id})}.sum(:summ) +
    DocumentsBeznalSchet.where{event_id.in(company_events.select{id})}.sum(:summ)
  end

end
