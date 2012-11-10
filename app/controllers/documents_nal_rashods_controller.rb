class DocumentsNalRashodsController < ApplicationController
  # GET /documents_nal_rashods
  # GET /documents_nal_rashods.json
  def index
    @documents_nal_rashods = DocumentsNalRashod.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents_nal_rashods }
    end
  end

  # GET /documents_nal_rashods/1
  # GET /documents_nal_rashods/1.json
  def show
    @documents_nal_rashod = DocumentsNalRashod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @documents_nal_rashod }
    end
  end

  # GET /documents_nal_rashods/new
  # GET /documents_nal_rashods/new.json
  def new
    @documents_nal_rashod = DocumentsNalRashod.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @documents_nal_rashod }
    end
  end

  # GET /documents_nal_rashods/1/edit
  def edit
    @documents_nal_rashod = DocumentsNalRashod.find(params[:id])
  end

  # POST /documents_nal_rashods
  # POST /documents_nal_rashods.json
  def create
    @documents_nal_rashod = DocumentsNalRashod.new(params[:documents_nal_rashod])

    respond_to do |format|
      if @documents_nal_rashod.save
        format.html { redirect_to @documents_nal_rashod, notice: 'Documents nal rashod was successfully created.' }
        format.json { render json: @documents_nal_rashod, status: :created, location: @documents_nal_rashod }
      else
        format.html { render action: "new" }
        format.json { render json: @documents_nal_rashod.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents_nal_rashods/1
  # PUT /documents_nal_rashods/1.json
  def update
    @documents_nal_rashod = DocumentsNalRashod.find(params[:id])

    respond_to do |format|
      if @documents_nal_rashod.update_attributes(params[:documents_nal_rashod])
        format.html { redirect_to @documents_nal_rashod, notice: 'Documents nal rashod was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @documents_nal_rashod.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents_nal_rashods/1
  # DELETE /documents_nal_rashods/1.json
  def destroy
    @documents_nal_rashod = DocumentsNalRashod.find(params[:id])
    @documents_nal_rashod.destroy

    respond_to do |format|
      format.html { redirect_to documents_nal_rashods_url }
      format.json { head :no_content }
    end
  end
end
