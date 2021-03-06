# -*- coding: utf-8 -*-

class Event < ActiveRecord::Base
  acts_as_paranoid

  attr_accessible :city, :company_id, :date_end, :date_start, :name, :user_id
  belongs_to :user
  belongs_to :company
  has_many :documents_beznal_rashods, :dependent => :destroy
  has_many :documents_beznal_schets, :dependent => :destroy
  has_many :documents_nal_rashods, :dependent => :destroy
  has_many :documents_nal_prihods

  validates_as_paranoid
  validates :company_id, :user_id, :name, :presence => true
  validates_uniqueness_of_without_deleted :name, { :scope => :company_id,
    :message => "событие с таким именем для этой компании уже создано" }

  scope :active, where(archived: false)
  scope :archive, where(archived: true)
  scope :latest, order('date_start DESC')
  scope :nearest, order('date_start')

  def date_range_str
    "#{date_start.strftime("%d.%m.%Y")} - #{date_end.strftime("%d.%m.%Y")}"
  end

end
