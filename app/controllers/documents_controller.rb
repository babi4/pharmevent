# encoding: utf-8

class DocumentsController < ApplicationController

  def index
    @document_types = [['Все документы', 'all'], ['Безналичный расход', 'beznal_rashod'], ['Безналичный приход', 'beznal_prihod'], ['Наличный расход', 'nal_rashod'], ['Наличный приход', 'nal_prihod']]
    if can? :manage, :company_consumption
      @document_types << ['Расходы компании', 'company_consumption']
    end

    if params.has_key?(:search)
      params[:search][:can_company_consumption] = can? :manage, :company_consumption
    else
      params[:search] = {:can_company_consumption => "#{can? :manage, :company_consumption}"} 
    end

    if params[:document_type] == 'all'

      if params[:search] && params[:search].delete_if{ |k, v| v != true and v.empty? }.count > 2
        @documents_beznal_rashod = DocumentsBeznalRashod.accessible_by(current_ability).search params[:search]
        @documents_beznal_schet = DocumentsBeznalSchet.accessible_by(current_ability).search params[:search]
        @documents_nal_rashod = DocumentsNalRashod.accessible_by(current_ability).search params[:search]
        @documents_nal_prihod = DocumentsNalPrihod.accessible_by(current_ability).search params[:search]
      elsif params[:search][:state] == 'completed'
        @events = Event.accessible_by(current_ability).completed_documents
      elsif params[:search][:state] == 'new'
        @events = Event.accessible_by(current_ability).uncompleted_documents
      end
    elsif params[:document_type]
      case params[:document_type]
      when 'beznal_rashod'
        @documents_beznal_rashod = DocumentsBeznalRashod.accessible_by(current_ability).search params[:search]
      when 'beznal_prihod'
        if !params[:only_uncompleted].blank?
          @documents_beznal_schet = DocumentsBeznalSchet.accessible_by(current_ability).for_closing
        else
          @documents_beznal_schet = DocumentsBeznalSchet.accessible_by(current_ability).search params[:search]
        end
      when 'nal_rashod'
        @documents_nal_rashod = DocumentsNalRashod.accessible_by(current_ability).search params[:search]
      when 'nal_prihod'
        @documents_nal_prihod = DocumentsNalPrihod.accessible_by(current_ability).search params[:search]
      when 'company_consumption'
        params[:search][:company_consumption] = true
        @documents_beznal_rashod = DocumentsBeznalRashod.accessible_by(current_ability).search params[:search]
        @documents_nal_rashod = DocumentsNalRashod.accessible_by(current_ability).search params[:search]
      end
    else
      params[:document_type] = 'all'
      params[:search][:state] = 'new'
      @events = Event.accessible_by(current_ability).uncompleted_documents
    end
  end

end
