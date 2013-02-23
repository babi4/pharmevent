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

  scope :active, lambda { where(archived: false).where('date_end >= ?', DateTime.now.to_date) }
  scope :archive, lambda { where('archived = true or date_end < ?', DateTime.now.to_date) }
  scope :uncompleted_documents, lambda { active.joins(:documents_beznal_rashods).merge( DocumentsBeznalRashod.unscoped.uncompleted ) | active.joins(:documents_nal_rashods).merge( DocumentsNalRashod.unscoped.uncompleted ) | active.joins(:documents_nal_prihods).merge( DocumentsNalPrihod.unscoped.uncompleted | active.joins(:documents_beznal_schets).merge( DocumentsBeznalSchet.unscoped.uncompleted ) ) }
  scope :completed_documents, lambda { active.joins(:documents_beznal_rashods).merge( DocumentsBeznalRashod.unscoped.completed ) | active.joins(:documents_nal_rashods).merge( DocumentsNalRashod.unscoped.completed ) | active.joins(:documents_nal_prihods).merge( DocumentsNalPrihod.unscoped.completed | active.joins(:documents_beznal_schets).merge( DocumentsBeznalSchet.unscoped.completed ) ) }
  scope :latest, order('date_start DESC')
  scope :nearest, order('date_start')

  def date_range_str
    "#{date_start.strftime("%d.%m.%Y")} - #{date_end.strftime("%d.%m.%Y")}"
  end

end
