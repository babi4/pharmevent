# -*- coding: utf-8 -*-

class CompanyMember < ActiveRecord::Base
  acts_as_paranoid

  attr_accessible :company_id, :email, :name, :position, :telephone
  belongs_to :company

  validates :company_id, :name, :presence => true

  validates_as_paranoid
  validates_uniqueness_of_without_deleted :name,  { :scope => :company_id,
                                                    :message => "представитель с таким именем для этой компании уже создан" }

end
