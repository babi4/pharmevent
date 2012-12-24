# -*- coding: utf-8 -*-

class DocumentsNalRashod < ActiveRecord::Base
  extend DocumentStatesModule
  DocumentStatesModule.included(self)

  default_scope where { state != 'deleted' }

  attr_accessible :state, :company, :date, :description, :entire, :lectors, :name, :summ, :telephone, :user_id, :event_id

  belongs_to :user
  belongs_to :event

  validates :event_id, :user_id, :company, :summ, :date, :presence => true
  validate :lectors_and_entire_fields


  private

  def lectors_and_entire_fields
    unless lectors ^ entire
      if lectors
        errors.add(:lectors, "Не могут быть отмеченны одновременно два типа расхода")
        errors.add(:entire, "Не могут быть отмеченны одновременно два типа расхода")
      else
        errors.add(:lectors, "Должен быть отмечен один тип расхода")
        errors.add(:entire, "Должен быть отмечен один тип расхода")
      end
    end
  end

end
