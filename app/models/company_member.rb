# -*- coding: utf-8 -*-

class CompanyMember < ActiveRecord::Base
  attr_accessible :company_id, :email, :name, :position, :telephone
  belongs_to :company

  validates :company_id, :name, :presence => true
  validates :name, :uniqueness => { :scope => :company_id,
                                    :message => "представитель с таким именем для этой компании уже создан" }

end
