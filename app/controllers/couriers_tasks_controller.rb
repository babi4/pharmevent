# encoding: utf-8

class CouriersTasksController < ApplicationController
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @couriers_tasks }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @couriers_task }
    end
  end

  def new
    tomorrow = DateTime.tomorrow
    @couriers_company_members = CouriersCompany.first.couriers_company_members #TODO member should be related with company

    @couriers_task[:due_time] = DateTime.new(tomorrow.year, tomorrow.month, tomorrow.day, 12, 0, 0, 0)
    @couriers_companies = CouriersCompany.all
    @couriers_companies.each do |company|
      address = "#{company.zip_code}, г.#{company.city}, ул.#{company.street}, дом #{company.house}"
      address += ", строение #{company.stroenie}" unless company.stroenie.blank?
      address += ", офис #{company.office}" unless company.office.blank?
      company[:full_address] = address
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @couriers_task }
    end
  end

  def edit
    @couriers_company_members = CouriersCompany.first.couriers_company_members #TODO member should be related with company

    @couriers_companies = CouriersCompany.all
    @couriers_companies.each do |company|
      address = "#{company.zip_code}, г.#{company.city}, ул.#{company.street}, дом #{company.house}"
      address += ", строение #{company.stroenie}" unless company.stroenie.blank?
      address += ", офис #{company.office}" unless company.office.blank?
      company[:full_address] = address
    end
    
    @date = @couriers_task[:due_time].strftime("%d.%m.%Y") 
    @time = @couriers_task[:due_time].strftime("%H:%M") 
  end

  def create
    @couriers_task[:user_id] = current_user[:id]
    @couriers_task[:name] = Time.now.to_i
    date = params[:date].split '.'
    time = params[:time].split ':'
    @couriers_task[:due_time] = DateTime.new(date[2].to_i, date[1].to_i, date[0].to_i, time[0].to_i, time[1].to_i)
    respond_to do |format|
      if @couriers_task.save
        format.html { redirect_to couriers_tasks_path, notice: 'Задание курьеру создано.' }
        format.json { render json: @couriers_task, status: :created, location: @couriers_task }
      else
        format.html { render action: "new" }
        format.json { render json: @couriers_task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    #params[:couriers_task][:user_id] = current_user[:id]
    date = params[:date].split '.'
    time = params[:time].split ':'
    @couriers_task[:due_time] = DateTime.new(date[2].to_i, date[1].to_i, date[0].to_i, time[0].to_i, time[1].to_i)
    respond_to do |format|
      if @couriers_task.update_attributes(params[:couriers_task])
        format.html { redirect_to couriers_tasks_path, notice: 'Задание курьеру изменено.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @couriers_task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @couriers_task.destroy
    respond_to do |format|
      format.html { redirect_to couriers_tasks_url }
      format.json { head :no_content }
    end
  end
end
