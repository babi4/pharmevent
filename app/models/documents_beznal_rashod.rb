# -*- coding: utf-8 -*-

class DocumentsBeznalRashod < ActiveRecord::Base

  default_scope where { state != 'deleted' }

  scope :uncompleted, where { state << %w(completed deleted) }
  scope :completed,   where(:state => 'completed')
  scope :by_company, where { event_id == 0 }

  attr_accessible :state_note, :state, :event_id, :company, :date_schet, :description, :dogovor_date, :dogovor_num, :entire, :info_act, :info_date_act, :info_date_pay, :info_date_schet, :info_name_sender, :info_pp, :info_type_return_act, :info_return_date, :info_schet_factura, :info_state_act, :lectors, :name, :nds, :num_schet, :summ, :telephone, :type_company, :type_rashod, :user_id

  belongs_to :user
  belongs_to :event

  validates :event_id, :user_id, :company, :type_company, :summ, :presence => true
  validate :state_act_typo

  state_machine :state, :initial => :new do

    state :new       # Новый (менеджер, гендир)
    state :signed    # Подписано/на доработку (менеджер, гендир)
    state :for_revision
    state :revised
    state :paid      # Оплачено (бухгалтер, гендир)
    state :received  # Документы получены  (бухгалтер, гендир)
    state :completed # Завершено
    state :deleted

    event :sign do
      transition [:new, :for_revision, :revised] => :signed
    end

    event :send_for_revision do
      transition [:new, :revised] => :for_revision
    end

    event :revise do
      transition :for_revision => :revised
    end

    event :pay do
      transition :signed => :paid
    end

    event :receive do
      transition :paid => :received
    end

    event :complete do
      transition :received => :completed
    end

    event :remove do
      transition all => :deleted
    end

  end


  def self.search(params = {})
    result = self.scoped

    if params[:can_company_consumption]
      result = result.by_company if params[:company_consumption]
    else
      result = result.where('event_id > 0')
    end

    result = result.where(:state => params[:state])                        unless params[:state].blank?
    result = result.where(:num_schet => params[:schet_num])                unless params[:schet_num].blank?
    result = result.where(:date_schet => Date.parse(params[:schet_date]))  unless params[:schet_date].blank?
    result = result.where(:summ => params[:schet_sum])                     unless params[:schet_sum].blank?

    result = result.where(:info_act => params[:act_num])                   unless params[:act_num].blank?
    result = result.where(:info_date_act => Date.parse(params[:act_date])) unless params[:act_date].blank?

    result = result.where(:info_schet_factura => params[:fact_num])           unless params[:fact_num].blank?
    result = result.where(:info_date_schet => Date.parse(params[:fact_date])) unless params[:fact_date].blank?

    result.includes(:event)
  end


  private

    def state_act_typo
      unless info_state_act.nil? || %w(отправлен не\ отправлен).include?(info_state_act)
        errors.add(:info_state_act, "Недопустимое значение. (отправлен неотправлен)")
      end
      unless info_type_return_act.nil? || %w(\  почтой курьером службой\ доставки).include?(info_type_return_act)
        errors.add(:info_state_act, "Недопустимое значение. (почтой курьером службой_доставки)")
      end
    end

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
