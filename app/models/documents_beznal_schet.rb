# -*- coding: utf-8 -*-

class DocumentsBeznalSchet < ActiveRecord::Base
  extend DocumentStatesModule
  DocumentStatesModule.included(self)

  default_scope where { state != 'deleted' }
  scope :unsigned, where(:state => ['new', 'added', 'for_revision'])

  attr_accessible :state_note, :num_schet, :date_schet, :state, :nds, :payment_date, :company_id, :description, :dogovor_date, :dogovor_num, :info_act, :info_date_act, :info_date_schet, :info_name_sender, :info_type_return_act, :info_return_date, :info_schet_factura, :info_state_act, :name, :summ, :telephone, :user_id, :event_id

  belongs_to :user
  belongs_to :event
  belongs_to :company

  validates :event_id, :user_id, :company_id, :summ, :nds, :presence => true
  validate :state_act_typo

  before_create do
    self.num_schet = DocumentsBeznalSchet.next_num_schet
    self.date_schet = DateTime.now
  end

  def self.next_num_schet
    DocumentsBeznalSchet.unscoped.where { date_schet > DateTime.now.beginning_of_year } .count + 1
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
