# encoding: utf-8

class DocumentsNalRashodsController < NalRashodsController
  load_and_authorize_resource :event
  load_and_authorize_resource :documents_nal_rashod, :through => :event

end
