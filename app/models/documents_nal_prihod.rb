class DocumentsNalPrihod < ActiveRecord::Base
  attr_accessible :company, :date, :description, :name, :summ, :telephone, :user_id
end
