class DocumentBeznalSchetsController < ApplicationController
  # GET /document_beznal_schets
  # GET /document_beznal_schets.json
  def index
    @document_beznal_schets = DocumentBeznalSchet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @document_beznal_schets }
    end
  end

  # GET /document_beznal_schets/1
  # GET /document_beznal_schets/1.json
  def show
    @document_beznal_schet = DocumentBeznalSchet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document_beznal_schet }
    end
  end

  # GET /document_beznal_schets/new
  # GET /document_beznal_schets/new.json
  def new
    @document_beznal_schet = DocumentBeznalSchet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document_beznal_schet }
    end
  end

  # GET /document_beznal_schets/1/edit
  def edit
    @document_beznal_schet = DocumentBeznalSchet.find(params[:id])
  end

  # POST /document_beznal_schets
  # POST /document_beznal_schets.json
  def create
    @document_beznal_schet = DocumentBeznalSchet.new(params[:document_beznal_schet])

    respond_to do |format|
      if @document_beznal_schet.save
        format.html { redirect_to @document_beznal_schet, notice: 'Document beznal schet was successfully created.' }
        format.json { render json: @document_beznal_schet, status: :created, location: @document_beznal_schet }
      else
        format.html { render action: "new" }
        format.json { render json: @document_beznal_schet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /document_beznal_schets/1
  # PUT /document_beznal_schets/1.json
  def update
    @document_beznal_schet = DocumentBeznalSchet.find(params[:id])

    respond_to do |format|
      if @document_beznal_schet.update_attributes(params[:document_beznal_schet])
        format.html { redirect_to @document_beznal_schet, notice: 'Document beznal schet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document_beznal_schet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_beznal_schets/1
  # DELETE /document_beznal_schets/1.json
  def destroy
    @document_beznal_schet = DocumentBeznalSchet.find(params[:id])
    @document_beznal_schet.destroy

    respond_to do |format|
      format.html { redirect_to document_beznal_schets_url }
      format.json { head :no_content }
    end
  end
end
