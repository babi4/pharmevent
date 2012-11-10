class DocumentBeznalSchet < ActiveRecord::Base
  attr_accessible :company, :date_schet, :description, :dogovor_date, :dogovor_num, :info_act, :info_date_act, :info_date_schet, :info_name_sender, :info_return_act_type, :info_return_date, :info_schet_factura, :info_state_act, :name, :num_schet, :summ, :telephone, :user_id
end
