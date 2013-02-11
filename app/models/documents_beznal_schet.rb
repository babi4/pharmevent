# -*- coding: utf-8 -*-

class DocumentsBeznalSchet < ActiveRecord::Base
  extend DocumentStatesModule
  DocumentStatesModule.included(self)

  default_scope where { state != 'deleted' }
  scope :unsigned, where(:state => %w(new added for_revision))

  attr_accessible :state_note, :num_schet, :date_schet, :state, :nds, :payment_date, :company_id, :description, :dogovor_date, :dogovor_num, :info_act, :info_date_act, :info_date_schet, :info_name_sender, :info_type_return_act, :info_return_date, :info_return_status, :info_schet_factura, :info_state_act, :name, :summ, :telephone, :user_id, :event_id

  belongs_to :user
  belongs_to :event
  belongs_to :company

  validates :event_id, :user_id, :company_id, :summ, :nds, :presence => true
  validate :state_act_typo

  # before_create do
  #   self.num_schet = DocumentsBeznalSchet.next_num_schet
  #   self.date_schet = DateTime.now
  # end

  def self.next_num_schet
    DocumentsBeznalSchet.unscoped.where { date_schet > DateTime.now.beginning_of_year } .count + 1
  end

  def self.search(params = {})
    result = self.scoped

    result = result.where(:num_schet => params[:schet_num])                unless params[:schet_num].blank?
    result = result.where(:date_schet => Date.parse(params[:schet_date]))  unless params[:schet_date].blank?
    result = result.where(:summ => params[:schet_sum])                     unless params[:schet_sum].blank?

    result = result.where(:info_act => params[:act_num])                   unless params[:act_num].blank?
    result = result.where(:info_date_act => Date.parse(params[:act_date])) unless params[:act_date].blank?

    result = result.where(:info_schet_factura => params[:fact_num])           unless params[:fact_num].blank?
    result = result.where(:info_date_schet => Date.parse(params[:fact_date])) unless params[:fact_date].blank?

    result.includes(:event, :company)
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

end
