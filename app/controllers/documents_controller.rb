# encoding: utf-8

class DocumentsController < ApplicationController

  def index
    if params[:search] && params[:search].delete_if{ |k, v| v.empty? }.count > 0
      if params[:type_in]
        @documents_nal_prihod = DocumentsNalPrihod.search params[:search]
        @documents_beznal_schet = DocumentsBeznalSchet.search params[:search]
      end
      if params[:type_out]
        @documents_nal_rashod = DocumentsNalRashod.search params[:search]
        @documents_beznal_rashod = DocumentsBeznalRashod.search params[:search]
      end
    else
      if params[:document_type] == 'all'
        if params[:document_state] == 'completed'
          @events = Event.completed_documents
        elsif params[:document_state] == 'uncompleted'
          @events = Event.uncompleted_documents
        end
      elsif params[:document_type]
        params[:search][:state] = params[:document_state]
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
        params[:document_state] = 'uncompleted'
        @events = Event.uncompleted_documents
      end
    end
  end

end
