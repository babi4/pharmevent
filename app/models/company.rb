# -*- coding: utf-8 -*-

class Company < ActiveRecord::Base
  acts_as_paranoid

  attr_accessible :full_address, :bank_account, :bank_corr_account, :bank_bik, :bank_city, :bank_house, :bank_name, :bank_office, :bank_street, :bank_stroenie, :bank_zip, :company_type, :email, :fax, :inn, :ispolnitel, :kpp, :name, :ogrn, :okpo, :okved, :okato, :osnovanie_ispolnitel, :post_city, :post_house, :post_office, :post_street, :post_stroenie, :post_zip_code, :short_name, :telephone, :ur_city, :ur_house, :ur_office, :ur_post_equal, :ur_street, :ur_stroenie, :ur_zip_code
  attr_accessor :full_address


  has_many :events, :dependent => :destroy
  has_many :company_members, :dependent => :destroy
  has_many :documents_beznal_schets

  validates :name, :ur_zip_code, :ur_city, :ur_street, :ur_house, :presence => true

  validates_as_paranoid
  validates_uniqueness_of_without_deleted :name

  COMPANY_ADDRESS_FIELDS = %w(city house office street stroenie zip_code)

  COMPANY_ADDRESS_FIELDS.each do |method|
    define_method method do
      if self.ur_post_equal
        self.send("ur_#{method}")
      else
        self.send("post_#{method}")
      end
    end
  end

  def transferred_funds
    self_id = self[:id] # yes, it is necessary
    company_events = Event.where{ company_id == self_id }
    DocumentsNalPrihod.where{event_id.in(company_events.select{id})}.sum(:summ) +
    DocumentsBeznalSchet.where{event_id.in(company_events.select{id})}.sum(:summ)
  end

  def ur_full_address
    addr = "#{ur_zip_code}, г.#{ur_city}, ул.#{ur_street}, дом #{ur_house}"
    addr += ", строение #{ur_stroenie}" unless ur_stroenie.blank?
    addr += ", офис #{ur_office}" unless ur_office.blank?
    addr
  end
end
