# encoding: utf-8

class CompanyBeznalRashodsController < BeznalRashodsController
  load_and_authorize_resource :documents_beznal_rashod, :parent => false

  before_filter :fix_event_id

  private

  def fix_event_id
    @documents_beznal_rashod[:event_id] = 0
    @event = '/company_consumptions' # redirect to company
  end

end
