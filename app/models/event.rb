# -*- coding: utf-8 -*-

class Event < ActiveRecord::Base
  attr_accessible :city, :company_id, :date_end, :date_start, :name, :user_id
  belongs_to :user
  belongs_to :company
  has_many :documents_beznal_rashods
  has_many :documents_beznal_schets
  has_many :documents_nal_rashods
  has_many :documents_nal_prihods

  validates :company_id, :user_id, :name, :presence => true
  validates :name, :uniqueness => { :scope => :company_id,
    :message => "событие с таким именем для этой компании уже создано" }

end
