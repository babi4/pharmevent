class Event < ActiveRecord::Base
  attr_accessible :city, :company_id, :date_end, :date_start, :name, :state, :user_id
end
