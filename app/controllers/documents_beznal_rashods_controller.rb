class DocumentsBeznalRashodsController < ApplicationController
  # GET /documents_beznal_rashods
  # GET /documents_beznal_rashods.json
  def index
    @documents_beznal_rashods = DocumentsBeznalRashod.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents_beznal_rashods }
    end
  end

  # GET /documents_beznal_rashods/1
  # GET /documents_beznal_rashods/1.json
  def show
    @documents_beznal_rashod = DocumentsBeznalRashod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @documents_beznal_rashod }
    end
  end

  # GET /documents_beznal_rashods/new
  # GET /documents_beznal_rashods/new.json
  def new
    @documents_beznal_rashod = DocumentsBeznalRashod.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @documents_beznal_rashod }
    end
  end

  # GET /documents_beznal_rashods/1/edit
  def edit
    @documents_beznal_rashod = DocumentsBeznalRashod.find(params[:id])
  end

  # POST /documents_beznal_rashods
  # POST /documents_beznal_rashods.json
  def create
    @documents_beznal_rashod = DocumentsBeznalRashod.new(params[:documents_beznal_rashod])

    respond_to do |format|
      if @documents_beznal_rashod.save
        format.html { redirect_to @documents_beznal_rashod, notice: 'Documents beznal rashod was successfully created.' }
        format.json { render json: @documents_beznal_rashod, status: :created, location: @documents_beznal_rashod }
      else
        format.html { render action: "new" }
        format.json { render json: @documents_beznal_rashod.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents_beznal_rashods/1
  # PUT /documents_beznal_rashods/1.json
  def update
    @documents_beznal_rashod = DocumentsBeznalRashod.find(params[:id])

    respond_to do |format|
      if @documents_beznal_rashod.update_attributes(params[:documents_beznal_rashod])
        format.html { redirect_to @documents_beznal_rashod, notice: 'Documents beznal rashod was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @documents_beznal_rashod.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents_beznal_rashods/1
  # DELETE /documents_beznal_rashods/1.json
  def destroy
    @documents_beznal_rashod = DocumentsBeznalRashod.find(params[:id])
    @documents_beznal_rashod.destroy

    respond_to do |format|
      format.html { redirect_to documents_beznal_rashods_url }
      format.json { head :no_content }
    end
  end
end
