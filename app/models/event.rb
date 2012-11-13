# -*- coding: utf-8 -*-

class Event < ActiveRecord::Base
  attr_accessible :city, :company_id, :date_end, :date_start, :name, :state, :user_id
  belongs_to :user
  belongs_to :company

  validates :company_id, :user_id, :name, :presence => true
  validates :name, :uniqueness => { :scope => :company_id,
    :message => "событие с таким именем для этой компании уже создано" }

end
