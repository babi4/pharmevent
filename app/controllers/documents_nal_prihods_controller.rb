class DocumentsNalPrihodsController < ApplicationController
  authorize_resource
  before_filter :detect_event

  def index
    @documents_nal_prihods = @event.documents_nal_prihods

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents_nal_prihods }
    end
  end

  def show
    @documents_nal_prihod = @event.documents_nal_prihods.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @documents_nal_prihod }
    end
  end

  def new
    @documents_nal_prihod = DocumentsNalPrihod.new
    @documents_nal_prihod[:date] = DateTime.now.tomorrow.strftime("%d.%m.%Y")

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @documents_nal_prihod }
    end
  end

  def edit
    @documents_nal_prihod = @event.documents_nal_prihods.find(params[:id])
  end

  def create
    @documents_nal_prihod = @event.documents_nal_prihods.new(params[:documents_nal_prihod])
    @documents_nal_prihod[:user_id] = current_user[:id]

    respond_to do |format|
      if @documents_nal_prihod.save
        format.html { redirect_to [@event, @documents_nal_prihod], notice: 'Documents nal prihod was successfully created.' }
        format.json { render json: @documents_nal_prihod, status: :created, location: @documents_nal_prihod }
      else
        format.html { render action: "new" }
        format.json { render json: @documents_nal_prihod.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @documents_nal_prihod = @event.documents_nal_prihods.find(params[:id])

    respond_to do |format|
      if @documents_nal_prihod.update_attributes(params[:documents_nal_prihod])
        format.html { redirect_to [@event, @documents_nal_prihod], notice: 'Documents nal prihod was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @documents_nal_prihod.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @documents_nal_prihod = @event.documents_nal_prihods.find(params[:id])
    @documents_nal_prihod.destroy

    respond_to do |format|
      format.html { redirect_to event_documents_nal_prihods_url(@event) }
      format.json { head :no_content }
    end
  end
end
