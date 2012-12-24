# encoding: utf-8

class DocumentsNalPrihodsController < ApplicationController
  load_and_authorize_resource :event
  load_and_authorize_resource :documents_nal_prihod, :through => :event

  def update_state
    update_document_state(@documents_nal_prihod, params[:transaction], params[:state_note])

    respond_to do |format|
      format.html { redirect_to event_documents_nal_prihods_path(@event) }
      format.json { head :no_content }
    end
  end

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents_nal_prihods }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @documents_nal_prihod }
    end
  end

  def new
    @documents_nal_prihod[:date] = DateTime.now.strftime("%d.%m.%Y")

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @documents_nal_prihod }
    end
  end

  def edit
  end

  def create
    @documents_nal_prihod[:user_id] = current_user[:id]

    respond_to do |format|
      if @documents_nal_prihod.save
        format.html { redirect_to event_documents_nal_prihods_path(@event), notice: 'Наличный приход создан.' }
        format.json { render json: @documents_nal_prihod, status: :created, location: @documents_nal_prihod }
      else
        format.html { render action: "new" }
        format.json { render json: @documents_nal_prihod.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @documents_nal_prihod.update_attributes(params[:documents_nal_prihod])
        format.html { redirect_to event_documents_nal_prihods_path(@event), notice: 'Наличный приход изменен.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @documents_nal_prihod.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @documents_nal_prihod.destroy

    respond_to do |format|
      format.html { redirect_to event_documents_nal_prihods_path(@event) }
      format.json { head :no_content }
    end
  end
end
