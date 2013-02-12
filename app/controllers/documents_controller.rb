# encoding: utf-8

class DocumentsController < ApplicationController

  def index
    @events = Event.uncompleted_documents
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
