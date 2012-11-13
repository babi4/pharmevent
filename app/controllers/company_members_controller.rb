class CompanyMembersController < ApplicationController
  authorize_resource
  before_filter :detect_company

  def index
    @company_members = @company.company_members

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @company_members }
    end
  end

  def show
    @company_member = @company.company_members.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company_member }
    end
  end

  def new
    @company_member = @company.company_members.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company_member }
    end
  end

  def edit
    @company_member = @company.company_members.find(params[:id])
  end

  def create
    @company_member = @company.company_members.new(params[:company_member])

    respond_to do |format|
      if @company_member.save
        format.html { redirect_to [@company, @company_member], notice: 'Company member was successfully created.' }
        format.json { render json: @company_member, status: :created, location: @company_member }
      else
        format.html { render action: "new" }
        format.json { render json: @company_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @company_member = @company.company_members.find(params[:id])

    respond_to do |format|
      if @company_member.update_attributes(params[:company_member])
        format.html { redirect_to [@company, @company_member], notice: 'Company member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company_member = @company.company_members.find(params[:id])
    @company_member.destroy

    respond_to do |format|
      format.html { redirect_to company_company_members_url(@company) }
      format.json { head :no_content }
    end
  end

  private

    def detect_company
      @company = Company.find(params[:company_id]) if params[:company_id]
    end

end
