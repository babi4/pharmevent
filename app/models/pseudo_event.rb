# -*- coding: utf-8 -*-

class PseudoEvent < OpenStruct

  def self.company_event
    PseudoEvent.new(
      id: 0,
      name: 'Расходы компании'
    )
  end

  def self.model_name
    t = OpenStruct.new
    t.singular_route_key = 'event'
    t
  end

end
