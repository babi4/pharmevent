# -*- coding: utf-8 -*-

class DocumentsNalRashod < ActiveRecord::Base
  acts_as_paranoid

  default_scope where { state != 'deleted' }

  scope :uncompleted, where { state << %w(paid deleted) }
  scope :completed,   where(:state => 'paid')
  scope :by_company, where { event_id == 0 }

  attr_accessible :state_note, :state, :company, :date, :description, :entire, :lectors, :name, :summ, :telephone, :type_rashod, :user_id, :event_id

  belongs_to :user
  belongs_to :event

  validates :event_id, :user_id, :company, :summ, :presence => true

  state_machine :state, :initial => :new do

    state :new
    state :paid
    state :deleted

    event :pay do
      transition :new => :paid
    end

    event :remove do
      transition all => :deleted
    end
  end

  def self.search(params = {})
    if params[:act_num].blank? && params[:act_date].blank? && params[:fact_num].blank? && params[:fact_date].blank?
      result = self.scoped
      if params[:can_company_consumption]
        result = result.by_company if params[:company_consumption]
      else
        result = result.where('event_id > 0')
      end
      unless params[:state].blank?
        params[:state] = 'paid' if params[:state] == 'completed'
        result = result.where(:state => params[:state])
      end
      result = result.where(:description => params[:schet_num])       unless params[:schet_num].blank?
      result = result.where(:date => Date.parse(params[:schet_date])) unless params[:schet_date].blank?
      result = result.where(:summ => params[:schet_sum])              unless params[:schet_sum].blank?

      result
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
