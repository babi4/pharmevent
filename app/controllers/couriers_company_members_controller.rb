# encoding: utf-8

class CouriersCompanyMembersController < ApplicationController
  load_and_authorize_resource :couriers_company, :only => [:index, :update, :destroy]
  load_and_authorize_resource :couriers_company_member, :through => :couriers_company, :only => [:index, :update, :destroy]

  def index
    respond_to do |format|
      format.json { render json: @couriers_company_members.map { |t| q = t.attributes ; q.update({'class' => t.class.to_s}) } }
    end
  end

  def create
    company = CouriersCompany.find params[:company_id]
    company_member = company.couriers_company_members.create params[:company_member]

    respond_to do |format|
      if company_member.save
        format.html { redirect_to request.referer, notice: 'Контактное лицо добавлено.'  }
        format.json { render json: company_member, status: :created }
      else
        format.html { redirect_to request.referer, alert: 'Произошла ошибка.'  }
        format.json { render json: company_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @couriers_company_member.update_attributes(params[:company_member])
        format.html { redirect_to @couriers_company, notice: 'Контактное лицо сохранено.' }
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
