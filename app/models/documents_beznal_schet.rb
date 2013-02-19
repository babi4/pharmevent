# -*- coding: utf-8 -*-

class DocumentsBeznalSchet < ActiveRecord::Base
  acts_as_paranoid

  default_scope where { state != 'deleted' }
  scope :uncompleted, where { state << %w(completed deleted) }
  scope :completed,   where(:state => 'completed')
  scope :for_closing, lambda { uncompleted.joins(:event).where('date_end < ?', Time.zone.now) }

  attr_accessible :state_note, :num_schet, :date_schet, :state, :nds, :payment_date, :company_id, :description, :dogovor_date, :dogovor_num, :info_act, :info_date_act, :info_date_schet, :info_name_sender, :info_type_return_act, :info_return_date, :info_return_status, :info_schet_factura, :info_state_act, :name, :summ, :telephone, :type_schet, :user_id, :event_id

  belongs_to :user
  belongs_to :event
  belongs_to :company

  validates :event_id, :user_id, :company_id, :summ, :nds, :presence => true
  validate :state_act_typo

  # before_create do
  #   self.num_schet = DocumentsBeznalSchet.next_num_schet
  #   self.date_schet = DateTime.now
  # end

  state_machine :state, :initial => :new do

    state :new           # Новый (менеджер, гендир)
    state :added_to_1c   # Внесен в 1C  (бухгалтер, гендир)
    state :ready_to_post # Документы готовы(Админ директор, гендир)
    state :posted        # Документы отправлены(Админ директор, гендир)
    state :completed     # Завершено (Админ директор, гендир)
    state :deleted

    event :add_to_1c do
      transition :new => :added_to_1c
    end

    event :set_ready_to_post do
      transition :added_to_1c => :ready_to_post
    end

    event :post do
      transition :ready_to_post => :posted
    end

    event :complete do
      transition :posted => :completed
    end

    event :remove do
      transition all => :deleted
    end

  end

  def self.next_num_schet
    DocumentsBeznalSchet.unscoped.where { date_schet > DateTime.now.beginning_of_year } .count + 1
  end

  def self.search(params = {})
    result = self.scoped

    result = result.where(:state => params[:state])                        unless params[:state].blank?
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
      unless info_type_return_act.nil? || %w(\  почтой курьером службой\ доставки).include?(info_type_return_act)
        errors.add(:info_state_act, "Недопустимое значение. (почтой курьером службой_доставки)")
      end
    end

end
