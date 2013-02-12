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
        if params[:document_status] == 'completed'
          @events = Event.completed_documents
        elsif params[:document_status] == 'uncompleted'
          @events = Event.uncompleted_documents
        end
      else
        params[:document_status] = 'uncompleted'
        @events = Event.uncompleted_documents
      end
    end
  end

  def search
    if params[:search] && params[:search].delete_if{ |k, v| v.empty? }.count > 0
      if params[:type_in]
        @documents_nal_prihod = DocumentsNalPrihod.search params[:search]
        @documents_beznal_schet = DocumentsBeznalSchet.search params[:search]
      end
      if params[:type_out]
        @documents_nal_rashod = DocumentsNalRashod.search params[:search]
        @documents_beznal_rashod = DocumentsBeznalRashod.search params[:search]
      end
    end
  end

end
