# encoding: utf-8

class DocumentsController < ApplicationController

  def index
    if params[:document_type] == 'all'
      if params[:search] && params[:search].delete_if{ |k, v| v.empty? }.count > 1
        @documents_beznal_rashod = DocumentsBeznalRashod.search params[:search]
        @documents_beznal_schet = DocumentsBeznalSchet.search params[:search]
        @documents_nal_rashod = DocumentsNalRashod.search params[:search]
        @documents_nal_prihod = DocumentsNalPrihod.search params[:search]
      elsif params[:search][:state] == 'completed'
        @events = Event.completed_documents
      elsif params[:search][:state] == 'new'
        @events = Event.uncompleted_documents
      end
    elsif params[:document_type]
      case params[:document_type]
      when 'beznal_rashod'
        @documents_beznal_rashod = DocumentsBeznalRashod.search params[:search]
      when 'beznal_prihod'
        @documents_beznal_schet = DocumentsBeznalSchet.search params[:search]
      when 'nal_rashod'
        @documents_nal_rashod = DocumentsNalRashod.search params[:search]
      when 'nal_prihod'
        @documents_nal_prihod = DocumentsNalPrihod.search params[:search]
      end
    else
      params[:document_type] = 'all'
      params[:search] = {:state => 'new'}
      @events = Event.uncompleted_documents
    end
  end

end
