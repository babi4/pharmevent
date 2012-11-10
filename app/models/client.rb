class Client < ActiveRecord::Base
  attr_accessible :birthday, :degree, :name, :notes, :passport_number, :position, :work, :zagran_passport_number, :zagran_passport_use_before
end
