# encoding: utf-8

class DocumentsBeznalRashodsController < BeznalRashodsController
  load_and_authorize_resource :event
  load_and_authorize_resource :documents_beznal_rashod, :through => :event

  def edit
    @disable_fields = (current_user.roles.first.name == 'administrative_director')
  end

end
