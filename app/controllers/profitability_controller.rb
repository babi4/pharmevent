# encoding: utf-8

class ProfitabilityController < ApplicationController

  def index
    @event = 0
    if params[:from] and params[:to]
      params[:from] = Date.parse(params[:from])
      params[:to] = Date.parse(params[:to])
      @events = Event.where('(date_start >= ? and date_start <= ?) or (date_end >= ? and date_end <= ?)', params[:from], params[:to], params[:from], params[:to]) 
      @documents_nal_rashods = DocumentsNalRashod.by_company.where('date >= ? and date <= ?', params[:from], params[:to]) 
      @documents_beznal_rashods = DocumentsBeznalRashod.by_company.where('date_schet >= ? and date_schet <= ?', params[:from], params[:to]) 
    else
      @events = Event.all
      @documents_nal_rashods = DocumentsNalRashod.by_company
      @documents_beznal_rashods = DocumentsBeznalRashod.by_company
    end
    @rashod_summ = @documents_nal_rashods.sum(:summ) + @documents_beznal_rashods.sum(:summ)
  end

end
