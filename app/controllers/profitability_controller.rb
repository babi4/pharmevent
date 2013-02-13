# encoding: utf-8

class ProfitabilityController < ApplicationController

  def index
    @event = 0
    @events = Event.all
    @documents_nal_rashods = DocumentsNalRashod.by_company
    @documents_beznal_rashods = DocumentsBeznalRashod.by_company
    @rashod_summ = @documents_nal_rashods.sum(:summ) + @documents_beznal_rashods.sum(:summ)
  end

end
