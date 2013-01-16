# -*- coding: utf-8 -*-

class DocumentsBeznalRashod < ActiveRecord::Base
  extend DocumentStatesModule
  DocumentStatesModule.included(self)

  default_scope where { state != 'deleted' }
  scope :unsigned, where(:state => ['new', 'added', 'for_revision'])

  attr_accessible :state_note, :state, :event_id, :company, :date_schet, :description, :dogovor_date, :dogovor_num, :entire, :info_act, :info_date_act, :info_date_pay, :info_date_schet, :info_name_sender, :info_pp, :info_type_return_act, :info_return_date, :info_schet_factura, :info_state_act, :lectors, :name, :nds, :num_schet, :summ, :telephone, :type_company, :user_id

  belongs_to :user
  belongs_to :event

  validates :event_id, :user_id, :company, :type_company, :summ, :presence => true
  #validate :lectors_and_entire_fields
  validate :state_act_typo



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
