class CompanyMembersController < ApplicationController
  authorize_resource
  #before_filter :detect_company

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
    company = Company.find(params[:company_member][:company_id])

    if params[:company_member][:id].to_i > 0
      company_member = company.company_members.find(params[:company_member][:id])
      company_member.attributes = params[:company_member]
      member_action = 'edit'
    else
      company_member = company.company_members.new(params[:company_member].except(:id))
      member_action = 'new'
    end

    company_member.save

    render :json => {:company_member => company_member, :member_action => member_action}
  end

  def destroy
    company_member = Company.find(params[:company_id]).company_members.find(params[:id])
    company_member.destroy

    render :json => params[:id]
  end

  private

    def detect_company
      @company = Company.find(params[:company_id]) if params[:company_id]
    end

end
