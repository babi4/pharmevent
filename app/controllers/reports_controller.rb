# encoding: utf-8

class ReportsController < ApplicationController

  def index
    if params[:date]
      @report_from = Date.new(params[:date][:year].to_i,params[:date][:month].to_i, 1)
      @report_to = Date.new(params[:date][:year].to_i,params[:date][:month].to_i, -1)
      @events = current_user.events.where('date_end >= ? and date_end <= ?', @report_from, @report_to)
    else
      @report_from = Date.today
    end
  end

end
