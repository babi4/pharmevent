# -*- coding: utf-8 -*-

class DocumentsNalRashod < ActiveRecord::Base
  extend DocumentStatesModule
  DocumentStatesModule.included(self)

  default_scope where { state != 'deleted' }
  scope :unsigned, where(:state => %w(new added for_revision))

  attr_accessible :state_note, :state, :company, :date, :description, :entire, :lectors, :name, :summ, :telephone, :user_id, :event_id

  belongs_to :user
  belongs_to :event

  validates :event_id, :user_id, :company, :summ, :date, :presence => true
  validate :lectors_and_entire_fields

  def self.search(params = {})
    if params[:act_num].blank? && params[:act_date].blank? && params[:fact_num].blank? && params[:fact_date].blank?
      unless params[:schet_num].blank? && params[:schet_date].blank? && params[:schet_sum].blank?
        result = self.scoped
        result = result.where(:description => params[:schet_num])       unless params[:schet_num].blank?
        result = result.where(:date => Date.parse(params[:schet_date])) unless params[:schet_date].blank?
        result = result.where(:summ => params[:schet_sum])              unless params[:schet_sum].blank?
        result.includes(:event)
      end
    end
  end


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
