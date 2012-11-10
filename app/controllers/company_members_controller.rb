class CompanyMembersController < ApplicationController
  # GET /company_members
  # GET /company_members.json
  def index
    @company_members = CompanyMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @company_members }
    end
  end

  # GET /company_members/1
  # GET /company_members/1.json
  def show
    @company_member = CompanyMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company_member }
    end
  end

  # GET /company_members/new
  # GET /company_members/new.json
  def new
    @company_member = CompanyMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company_member }
    end
  end

  # GET /company_members/1/edit
  def edit
    @company_member = CompanyMember.find(params[:id])
  end

  # POST /company_members
  # POST /company_members.json
  def create
    @company_member = CompanyMember.new(params[:company_member])

    respond_to do |format|
      if @company_member.save
        format.html { redirect_to @company_member, notice: 'Company member was successfully created.' }
        format.json { render json: @company_member, status: :created, location: @company_member }
      else
        format.html { render action: "new" }
        format.json { render json: @company_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /company_members/1
  # PUT /company_members/1.json
  def update
    @company_member = CompanyMember.find(params[:id])

    respond_to do |format|
      if @company_member.update_attributes(params[:company_member])
        format.html { redirect_to @company_member, notice: 'Company member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_members/1
  # DELETE /company_members/1.json
  def destroy
    @company_member = CompanyMember.find(params[:id])
    @company_member.destroy

    respond_to do |format|
      format.html { redirect_to company_members_url }
      format.json { head :no_content }
    end
  end
end
