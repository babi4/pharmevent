# encoding: utf-8

class CouriersCompanyMembersController < ApplicationController
  load_and_authorize_resource

  def create
    respond_to do |format|
      if @couriers_company_member.save
        format.html { redirect_to request.referer, notice: 'Контактное лицо добавлено.'  }
        format.json { render json: @couriers_company, status: :created, location: @couriers_company }
      else
        format.html { redirect_to request.referer, alert: 'Произошла ошибка.'  }
        format.json { render json: @couriers_company.errors, status: :unprocessable_entity }
      end
    end
  end
end
