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

  scope :active, lambda { where(archived: false).where('date_end >= ?', DateTime.now.to_date) }
  scope :archive, lambda { where('archived = true or date_end < ?', DateTime.now.to_date) }
  scope :unsigned_documents, active.joins(:documents_beznal_rashods).merge( DocumentsBeznalRashod.unscoped.unsigned ) | active.joins(:documents_nal_rashods).merge( DocumentsNalRashod.unscoped.unsigned ) | active.joins(:documents_nal_prihods).merge( DocumentsNalPrihod.unscoped.unsigned | active.joins(:documents_beznal_schets).merge( DocumentsBeznalSchet.unscoped.unsigned ) )
  scope :latest, order('date_start DESC')
  scope :nearest, order('date_start')

end
