class CouriersCompaniesController < ApplicationController
  # GET /couriers_companies
  # GET /couriers_companies.json
  def index
    @couriers_companies = CouriersCompany.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @couriers_companies }
    end
  end

  # GET /couriers_companies/1
  # GET /couriers_companies/1.json
  def show
    @couriers_company = CouriersCompany.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @couriers_company }
    end
  end

  # GET /couriers_companies/new
  # GET /couriers_companies/new.json
  def new
    @couriers_company = CouriersCompany.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @couriers_company }
    end
  end

  # GET /couriers_companies/1/edit
  def edit
    @couriers_company = CouriersCompany.find(params[:id])
  end

  # POST /couriers_companies
  # POST /couriers_companies.json
  def create
    @couriers_company = CouriersCompany.new(params[:couriers_company])

    respond_to do |format|
      if @couriers_company.save
        format.html { redirect_to @couriers_company, notice: 'Couriers company was successfully created.' }
        format.json { render json: @couriers_company, status: :created, location: @couriers_company }
      else
        format.html { render action: "new" }
        format.json { render json: @couriers_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /couriers_companies/1
  # PUT /couriers_companies/1.json
  def update
    @couriers_company = CouriersCompany.find(params[:id])

    respond_to do |format|
      if @couriers_company.update_attributes(params[:couriers_company])
        format.html { redirect_to @couriers_company, notice: 'Couriers company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @couriers_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /couriers_companies/1
  # DELETE /couriers_companies/1.json
  def destroy
    @couriers_company = CouriersCompany.find(params[:id])
    @couriers_company.destroy

    respond_to do |format|
      format.html { redirect_to couriers_companies_url }
      format.json { head :no_content }
    end
  end
end
