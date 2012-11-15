class DocumentsNalRashodsController < ApplicationController
  authorize_resource
  before_filter :detect_event

  def index
    @documents_nal_rashods = @event.documents_nal_rashods

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents_nal_rashods }
    end
  end

  def show
    @documents_nal_rashod = @event.documents_nal_rashods.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @documents_nal_rashod }
    end
  end

  def new
    @documents_nal_rashod = DocumentsNalRashod.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @documents_nal_rashod }
    end
  end

  def edit
    @documents_nal_rashod = @event.documents_nal_rashods.find(params[:id])
  end

  def create
    @documents_nal_rashod = @event.documents_nal_rashods.new(params[:documents_nal_rashod])
    @documents_nal_rashod[:user_id] = current_user[:id]

    respond_to do |format|
      if @documents_nal_rashod.save
        format.html { redirect_to [@event, @documents_nal_rashod], notice: 'Documents nal rashod was successfully created.' }
        format.json { render json: @documents_nal_rashod, status: :created, location: @documents_nal_rashod }
      else
        format.html { render action: "new" }
        format.json { render json: @documents_nal_rashod.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @documents_nal_rashod = @event.documents_nal_rashods.find(params[:id])

    respond_to do |format|
      if @documents_nal_rashod.update_attributes(params[:documents_nal_rashod])
        format.html { redirect_to [@event, @documents_nal_rashod], notice: 'Documents nal rashod was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @documents_nal_rashod.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @documents_nal_rashod = @event.documents_nal_rashods.find(params[:id])
    @documents_nal_rashod.destroy

    respond_to do |format|
      format.html { redirect_to event_documents_nal_rashods_url(@event) }
      format.json { head :no_content }
    end
  end
end
