# encoding: utf-8

class CouriersCompaniesController < ApplicationController
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @couriers_companies }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @couriers_company }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @couriers_company }
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @couriers_company.save
        format.html { redirect_to @couriers_company, notice: 'Место добавлено.'  }
        format.json { render json: @couriers_company, status: :created, location: @couriers_company }
      else
        format.html { render action: "new" }
        format.json { render json: @couriers_company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @couriers_company.update_attributes(params[:couriers_company])
        format.html { redirect_to @couriers_company, notice: 'Место сохранено.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @couriers_company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @couriers_company.destroy
    respond_to do |format|
      format.html { redirect_to couriers_companies_path }
      format.json { head :no_content }
    end
  end
end
