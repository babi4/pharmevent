# -*- coding: utf-8 -*-

class CouriersTask < ActiveRecord::Base
  acts_as_paranoid

  attr_accessible :from_couriers_company_member_class, :to_couriers_company_member_class, :from_couriers_company_class, :to_couriers_company_class, :due_time, :from_couriers_company_id, :from_date, :name, :status, :note, :to_couriers_company_id, :to_date, :to_couriers_company_member_id, :from_couriers_company_member_id

  validates :name,
            :from_couriers_company_id, :to_couriers_company_id,
            :from_couriers_company_class, :to_couriers_company_class,
            :from_couriers_company_member_class, :from_couriers_company_member_id,
            :to_couriers_company_member_class, :to_couriers_company_member_id,
            :presence => true

  validates_as_paranoid
  validates_uniqueness_of_without_deleted :name

  validate :from_to_companies

  belongs_to :user

  %w[to from].each do |direction|
    ['', '_member'].each do |comp_or_memb|
      define_method "#{direction}_couriers_company#{comp_or_memb}" do
        self.send("#{direction}_couriers_company#{comp_or_memb}_class").constantize.with_deleted.find( self.send("#{direction}_couriers_company#{comp_or_memb}_id") )
      end
    end
  end

  private

  def from_to_companies
    if (from_couriers_company_id == to_couriers_company_id) && (from_couriers_company_class == to_couriers_company_class)
      errors.add(:to_couriers_company_id, "Место доставки не может совпадать с местом отправления")
    end
  end

end
