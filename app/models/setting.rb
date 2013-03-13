class Setting < ActiveRecord::Base

  attr_accessible :name, :value

  validates_uniqueness_of :name

  class << self
    def next_num_beznal_schet
      docs_in_year = DocumentsBeznalSchet.unscoped.where { date_schet > DateTime.now.beginning_of_year }
      next_num_beznal_schet_record.update_attribute(:value, 1) unless docs_in_year.exists?

      next_num_beznal_schet_record.value
    end

    def inc_num_beznal_schet
      next_num_beznal_schet_record.increment! :value
    end

    def dec_num_beznal_schet
      next_num_beznal_schet_record.decrement! :value
    end

    def next_num_beznal_schet_record
      find_by_name('next_num_beznal_schet')
    end
  end
end
