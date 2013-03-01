# encoding: utf-8

class CompanyNalRashodsController < NalRashodsController
  load_and_authorize_resource :documents_nal_rashod, :parent => false

  before_filter :fix_event_id, :except => :index

  def index
    render :nothing => true
  end

  def new
    @documents_nal_rashod[:type_rashod] = RASHOD_TYPES.keys.last
  end

  private

    def fix_event_id
      @documents_nal_rashod[:event_id] = 0
      @event = '/company_consumptions' # redirect to company
    end

end
