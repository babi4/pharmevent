# encoding: utf-8

class CouriersCompanyMembersController < ApplicationController
  load_and_authorize_resource :couriers_company
  load_and_authorize_resource :couriers_company_member, :through => :couriers_company

  def index
    respond_to do |format|
      format.json { render json: @couriers_company_members }
    end
  end

  def create
    respond_to do |format|
      if @couriers_company_member.save
        format.html { redirect_to request.referer, notice: 'Контактное лицо добавлено.'  }
        #format.json { render json: @couriers_company_member, status: :created, location: @couriers_company }
      else
        format.html { redirect_to request.referer, alert: 'Произошла ошибка.'  }
        #format.json { render json: @couriers_company_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @couriers_company_member.update_attributes(params[:couriers_company_member])
        #format.html { redirect_to couriers_tasks_path, notice: 'Задание курьеру изменено.' }
        format.json { head :no_content }
      else
        #format.html { render action: "edit" }
        format.json { render json: @couriers_task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @couriers_company_member.destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.json { head :no_content }
    end
  end

end
