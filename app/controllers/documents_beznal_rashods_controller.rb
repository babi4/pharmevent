# encoding: utf-8

class DocumentsBeznalRashodsController < BeznalRashodsController
  load_and_authorize_resource :event
  load_and_authorize_resource :documents_beznal_rashod, :through => :event

end
