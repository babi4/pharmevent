# encoding: utf-8

class DocumentsController < ApplicationController

  before_filter :set_document_types
  before_filter :set_company_consumption_ability
  before_filter :set_defaults

  def index
    @events =
      DocumentsAggregator.new(current_ability).
        in_document_type(params[:document_type]).
        add_search(params[:search]).
        group_by_events
  end

  private

    def set_document_types
      @document_types = [['Все документы', 'all'], ['Безналичный расход', 'documents_beznal_rashod'], ['Безналичный приход', 'documents_beznal_schet'], ['Наличный расход', 'documents_nal_rashod'], ['Наличный приход', 'documents_nal_prihod']]
      if can? :manage, :company_consumption
        @document_types << ['Расходы компании', 'company_consumption']
      end
    end

    def set_company_consumption_ability
      params[:search] ||= {}
      params[:search][:can_company_consumption] = can? :manage, :company_consumption
    end

    def set_defaults
      unless params.has_key?(:document_type)
        if %w(administrative_director chief_accountant).include? current_user.roles.first.name
          params[:document_type] = 'documents_beznal_schet'
          params[:search][:state] =
            current_user.roles.first.name == 'administrative_director' ? 'ready_to_post' : 'new'
        else
          params[:document_type] = 'all'
          params[:search][:state] = 'new'
        end
      end
    end

end

