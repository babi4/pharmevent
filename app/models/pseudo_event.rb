# -*- coding: utf-8 -*-

class PseudoEvent < OpenStruct

  def self.company_event
    PseudoEvent.new(
      id: 0,
      name: 'Расходы компании'
    )
  end

end
