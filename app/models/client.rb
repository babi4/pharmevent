class Client < ActiveRecord::Base
  acts_as_paranoid

  attr_accessible :birthday, :degree, :name, :notes, :passport_number, :position, :work, :zagran_passport_number, :zagran_passport_use_before

  validates_as_paranoid
  validates_uniqueness_of_without_deleted :name

  validates :name, :presence => true

end
