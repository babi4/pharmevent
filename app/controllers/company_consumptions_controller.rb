# encoding: utf-8

class CompanyConsumptionsController < ApplicationController
  authorize_resource :class => false

  def index
    @event = PseudoEvent.company_event
    @documents_nal_rashods = DocumentsNalRashod.by_company.accessible_by(current_ability)
    @documents_beznal_rashods = DocumentsBeznalRashod.by_company.accessible_by(current_ability)
    @rashod_summ = @documents_nal_rashods.sum(:summ) + @documents_beznal_rashods.sum(:summ)
  end

end
