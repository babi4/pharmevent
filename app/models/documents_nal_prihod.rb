class DocumentsNalPrihod < ActiveRecord::Base
  extend DocumentStatesModule
  DocumentStatesModule.included(self)

  attr_accessible :state, :company, :date, :description, :name, :summ, :telephone, :user_id, :event_id

  belongs_to :user
  belongs_to :event

  validates :event_id, :user_id, :company, :summ, :date, :presence => true

end
