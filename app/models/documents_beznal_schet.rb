class DocumentsBeznalSchet < ActiveRecord::Base
  extend DocumentStatesModule
  DocumentStatesModule.included(self)

  attr_accessible :state, :nds, :payment_date, :company_id, :date_schet, :description, :dogovor_date, :dogovor_num, :info_act, :info_date_act, :info_date_schet, :info_name_sender, :info_type_return_act, :info_return_date, :info_schet_factura, :info_state_act, :name, :num_schet, :summ, :telephone, :user_id, :event_id

  belongs_to :user
  belongs_to :event
  belongs_to :company

  validates :event_id, :user_id, :company_id, :summ, :nds, :presence => true

end
