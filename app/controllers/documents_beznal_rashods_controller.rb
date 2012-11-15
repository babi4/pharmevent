class DocumentsBeznalRashodsController < ApplicationController
  authorize_resource
  before_filter :detect_event

  def index
    @documents_beznal_rashods = @event.documents_beznal_rashods

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents_beznal_rashods }
    end
  end

  def show
    @documents_beznal_rashod = @event.documents_beznal_rashods.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @documents_beznal_rashod }
    end
  end

  def new
    @documents_beznal_rashod = DocumentsBeznalRashod.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @documents_beznal_rashod }
    end
  end

  def edit
    @documents_beznal_rashod = @event.documents_beznal_rashods.find(params[:id])
  end

  def create
    @documents_beznal_rashod = @event.documents_beznal_rashods.new(params[:documents_beznal_rashod])
    @documents_beznal_rashod[:user_id] = current_user[:id]

    respond_to do |format|
      if @documents_beznal_rashod.save
        format.html { redirect_to [@event, @documents_beznal_rashod], notice: 'Documents beznal rashod was successfully created.' }
        format.json { render json: @documents_beznal_rashod, status: :created, location: @documents_beznal_rashod }
      else
        format.html { render action: "new" }
        format.json { render json: @documents_beznal_rashod.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @documents_beznal_rashod = @event.documents_beznal_rashods.find(params[:id])

    respond_to do |format|
      if @documents_beznal_rashod.update_attributes(params[:documents_beznal_rashod])
        format.html { redirect_to [@event, @documents_beznal_rashod], notice: 'Documents beznal rashod was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @documents_beznal_rashod.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @documents_beznal_rashod = @event.documents_beznal_rashods.find(params[:id])
    @documents_beznal_rashod.destroy

    respond_to do |format|
      format.html { redirect_to event_documents_beznal_rashods_url(@event) }
      format.json { head :no_content }
    end
  end
end
