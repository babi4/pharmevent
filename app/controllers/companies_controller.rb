# encoding: utf-8

class CompaniesController < ApplicationController
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company.with(:company_members) }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Заказчик добавлен.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: 'Заказчик изменен.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
end
