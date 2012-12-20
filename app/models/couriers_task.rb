# -*- coding: utf-8 -*-

class CouriersTask < ActiveRecord::Base
  attr_accessible :due_time, :from_couriers_company_id, :from_date, :name, :status, :to_couriers_company_id, :to_date, :to_couriers_company_member_id, :from_couriers_company_member_id

  validates :name, :from_couriers_company_id, :to_couriers_company_id, :presence => true
  validates :name, :uniqueness => true
  validate :from_to_companies

  belongs_to :user

  belongs_to :to_couriers_company_member, :class_name => "CouriersCompanyMember",
             :foreign_key => "to_couriers_company_member_id"

  belongs_to :from_couriers_company_member, :class_name => "CouriersCompanyMember",
             :foreign_key => "from_couriers_company_member_id"

  belongs_to :to_couriers_company, :class_name => "CouriersCompany",
             :foreign_key => "to_couriers_company_id"

  belongs_to :from_couriers_company, :class_name => "CouriersCompany",
             :foreign_key => "from_couriers_company_id"

  private

  def from_to_companies
    if from_couriers_company_id == to_couriers_company_id
      errors.add(:to_couriers_company_id, "Место доставки не может совпадать с местом отправления")
    end
  end

end
