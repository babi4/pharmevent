# encoding: utf-8

class DocumentsController < ApplicationController

  def index
    @events = Event.unsigned_documents
  end

end
