class DocumentsNalPrihodsController < ApplicationController
  # GET /documents_nal_prihods
  # GET /documents_nal_prihods.json
  def index
    @documents_nal_prihods = DocumentsNalPrihod.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents_nal_prihods }
    end
  end

  # GET /documents_nal_prihods/1
  # GET /documents_nal_prihods/1.json
  def show
    @documents_nal_prihod = DocumentsNalPrihod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @documents_nal_prihod }
    end
  end

  # GET /documents_nal_prihods/new
  # GET /documents_nal_prihods/new.json
  def new
    @documents_nal_prihod = DocumentsNalPrihod.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @documents_nal_prihod }
    end
  end

  # GET /documents_nal_prihods/1/edit
  def edit
    @documents_nal_prihod = DocumentsNalPrihod.find(params[:id])
  end

  # POST /documents_nal_prihods
  # POST /documents_nal_prihods.json
  def create
    @documents_nal_prihod = DocumentsNalPrihod.new(params[:documents_nal_prihod])

    respond_to do |format|
      if @documents_nal_prihod.save
        format.html { redirect_to @documents_nal_prihod, notice: 'Documents nal prihod was successfully created.' }
        format.json { render json: @documents_nal_prihod, status: :created, location: @documents_nal_prihod }
      else
        format.html { render action: "new" }
        format.json { render json: @documents_nal_prihod.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents_nal_prihods/1
  # PUT /documents_nal_prihods/1.json
  def update
    @documents_nal_prihod = DocumentsNalPrihod.find(params[:id])

    respond_to do |format|
      if @documents_nal_prihod.update_attributes(params[:documents_nal_prihod])
        format.html { redirect_to @documents_nal_prihod, notice: 'Documents nal prihod was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @documents_nal_prihod.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents_nal_prihods/1
  # DELETE /documents_nal_prihods/1.json
  def destroy
    @documents_nal_prihod = DocumentsNalPrihod.find(params[:id])
    @documents_nal_prihod.destroy

    respond_to do |format|
      format.html { redirect_to documents_nal_prihods_url }
      format.json { head :no_content }
    end
  end
end
