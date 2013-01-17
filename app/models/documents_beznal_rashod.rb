# -*- coding: utf-8 -*-

class DocumentsBeznalRashod < ActiveRecord::Base
  extend DocumentStatesModule
  DocumentStatesModule.included(self)

  default_scope where { state != 'deleted' }
  scope :unsigned, where(:state => %w(new added for_revision))

  attr_accessible :state_note, :state, :event_id, :company, :date_schet, :description, :dogovor_date, :dogovor_num, :entire, :info_act, :info_date_act, :info_date_pay, :info_date_schet, :info_name_sender, :info_pp, :info_type_return_act, :info_return_date, :info_schet_factura, :info_state_act, :lectors, :name, :nds, :num_schet, :summ, :telephone, :type_company, :user_id

  belongs_to :user
  belongs_to :event

  validates :event_id, :user_id, :company, :type_company, :summ, :presence => true
  #validate :lectors_and_entire_fields
  validate :state_act_typo

  def self.search(params = {})
    result = self.scoped

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
      unless info_state_act.nil? || %w(отправлен неотправлен).include?(info_state_act)
        errors.add(:info_state_act, "Недопустимое значение. (отправлен неотправлен)")
      end
      unless info_type_return_act.nil? || %w(почтой курьером службой\ доставки).include?(info_type_return_act)
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
