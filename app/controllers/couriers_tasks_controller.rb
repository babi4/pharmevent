# encoding: utf-8

class CouriersTasksController < ApplicationController
  load_and_authorize_resource

  before_filter :preload_couriers_companies, :only => [:new, :edit]
  before_filter :set_due_time, :only => [:create, :update]


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
    @couriers_task[:due_time] = DateTime.new(tomorrow.year, tomorrow.month, tomorrow.day, 12, 0, 0, 0)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @couriers_task }
    end
  end

  def edit
    @date = @couriers_task[:due_time].strftime("%d.%m.%Y")
    @time = @couriers_task[:due_time].strftime("%H:%M") 
  end

  def create
    @couriers_task[:user_id] = current_user[:id]
    @couriers_task[:name] = Time.now.to_i
    respond_to do |format|
      if @couriers_task.save
        format.html { redirect_to couriers_tasks_path, notice: 'Задание курьеру создано.' }
        format.json { render json: @couriers_task, status: :created, location: @couriers_task }
      else
        format.html do
          preload_couriers_companies
          render action: "new"
        end
        format.json { render json: @couriers_task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    #params[:couriers_task][:user_id] = current_user[:id]
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

  def create_member
    company = params[:company][:class].constantize.find(params[:company][:id])
    company_member = company.company_members.create(params[:company_member])
    company_member_attr = company_member.attributes
    if company_member.save
      render json: {company_member: company_member_attr.update({'class' => company_member.class.to_s})  }
    else
      render json: {company_member: false}
    end
  end

  private

    def preload_couriers_companies
      @couriers_companies = CouriersCompany.all | Company.all
      @couriers_companies.each do |company|
        company.full_address = view_context.courier_company_address company
      end
    end

    def set_due_time
      date = params[:date].split '.'
      time = params[:time].split ':'
      @couriers_task[:due_time] = DateTime.new(date[2].to_i, date[1].to_i, date[0].to_i, time[0].to_i, time[1].to_i)
    end

end
